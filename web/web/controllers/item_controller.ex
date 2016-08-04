defmodule Placebooru.ItemController do
  use Placebooru.Web, :controller
  alias Placebooru.Item
  alias Placebooru.Tag
  alias Placebooru.LoginInteractor

  @static_path "/kyon/data/img/"

  def index(conn, _params) do
    render conn, "index.html"
  end

  @doc """
  Renders single Item page.
  """
  def view(conn, %{"id" => id}) do
    render conn, "view.html",
      item: Item.find_by_id(id),
      tags: Tag.for_item(id),
      comments: Placebooru.ItemComment.find_by_item_id(id)
  end

  @doc """
  Adds a tag and redirects to view/:id
  """
  def tag(conn, %{"id" => id, "tag" => unsafe_tags}) do
    item_id = String.to_integer(id)
    %{id: user_id} = LoginInteractor.remind(conn)
    unsafe_tags
    |> HtmlSanitizeEx.strip_tags
    |> String.split(" ", trim: true)
    |> Enum.each(fn tag_name -> Tag.insert_by_name(tag_name, item_id, user_id) end)
    SlackWebhook.async_send "New tags added"
    redirect(conn, to: "/item/" <> id <> "/_")
  end

  @doc """
  Adds a comment and redirects to view/:id
  """
  def comment(conn, %{"id" => id, "comment" => unsafe_comment}) do
    item_id = String.to_integer(id)
    %{id: user_id} = LoginInteractor.remind(conn)
    Repo.insert %Placebooru.ItemComment{
      content: HtmlSanitizeEx.strip_tags(unsafe_comment),
      user_id: user_id,
      item_id: item_id,
      created: Ecto.DateTime.utc()
    }
    SlackWebhook.async_send "New comment added"
    redirect(conn, to: "/item/" <> id <> "/_")
  end

  @doc """
  Renders page with image upload widget.
  """
  def preupload(conn, _params) do
    render conn, "preupload.html"
  end

  @doc """
  Saves uploaded Item.
  """
  def upload(conn, %{"item" => item, "source" => unsafe_source}) do
    %Plug.Upload{
      content_type: _content_type, # "image/png"
      filename: _original_name,    # "simple_image.png"
      path: tmp_path              # "/tmp/plug-1431/multipart-989804-534874-2"
    } = item

    handle_file_upload(conn, tmp_path, HtmlSanitizeEx.strip_tags(unsafe_source))
  end

  @doc """
  Fetches Item from web.
  """
  def upload(conn, %{"url" => unsafe_url}) do
    %HTTPoison.Response{body: unsafe_file_contents} = HTTPoison.get!(unsafe_url)

    # write to file, since we already have this route
    tmp_path = "/tmp/kyon-upload-" # TODO: add random ending
    File.write!(tmp_path, unsafe_file_contents)

    handle_file_upload(conn, tmp_path, HtmlSanitizeEx.strip_tags(unsafe_url))
  end

  defp handle_file_upload(conn, tmp_path, source) do
    %{id: user_id} = LoginInteractor.remind(conn)
    md5 = get_md5(tmp_path)
    existing_items = Item.find_by_md5(md5)
    case Enum.count(existing_items) do
      count when count > 0 ->
        existing_items
        |> hd
        |> redirect_to_item(conn)
      _ ->
        insert(md5, source, user_id)
        |> save_original(tmp_path)
        |> track_upload
        |> redirect_to_item(conn)
    end
  end

  defp get_md5(tmp_path) do
    File.read!(tmp_path)
    |> :erlang.md5
    |> Base.encode16(case: :lower)
  end

  defp redirect_to_item(item, conn) do
    item_id = Integer.to_string(item.id)
    redirect(conn, to: "/item/" <> item_id <> "/_")
  end

  defp insert(md5, source, user_id) do
    {:ok, item} = Repo.insert %Item{
      module: "img",
      md5: md5,
      source: source,
      user_id: user_id,
      created: Ecto.DateTime.utc()
    }
    # TODO: created is empty, not NOW()
    item
  end

  defp save_original(item, tmp_path) do
    item_id = Integer.to_string item.id
    File.copy!(tmp_path,
      @static_path <> prefix <> item_id <> ".jpg",
      :infinity)
    item
  end

  defp track_upload(item) do
    SlackWebhook.async_send "New item uploaded"
    item
  end

  defp prefix do
    %{file_prefix: file_prefix} = Application.get_env(:placebooru, :branding,
      %{file_prefix: "placebooru_"})
    file_prefix
  end

end
