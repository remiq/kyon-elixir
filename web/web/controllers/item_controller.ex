defmodule Placebooru.ItemController do
  use Placebooru.Web, :controller
  alias Placebooru.Item
  alias Placebooru.Tag
  alias Placebooru.LoginInteractor

  plug :action

  @static_path "priv/static/items/"

  def index(conn, _params) do
    render conn, "index.html"
  end

  def view(conn, %{"id" => id}) do
    """
    Renders single Item page.
    """
    render conn, "view.html",
      item: Item.find_by_id(id),
      tags: Tag.for_item(id),
      comments: Placebooru.ItemComment.find_by_item_id(id)
  end

  def tag(conn, %{"id" => id, "tag" => tag_string}) do
    """
    Adds a tag and redirects to view/:id
    """
    item_id = String.to_integer(id)
    [id: user_id, name: _] = LoginInteractor.remind(conn)
    # TODO: sanitize tag name - alphanumeric + _
    tag = Repo.get_by Tag, name: tag_string
    if tag == nil do
      tag = Repo.insert %Tag{
        name: tag_string
      }
    end
    tag_id = tag.id
    Repo.insert %Placebooru.TagItem{
      item_id: item_id,
      tag_id: tag_id
    }
    redirect(conn, to: "/item/" <> id <> "/_")
  end

  def comment(conn, %{"id" => id, "comment" => comment}) do
    """
    Adds a comment and redirects to view/:id
    """
    item_id = String.to_integer(id)
    [id: user_id, name: _] = LoginInteractor.remind(conn)
    Repo.insert %Placebooru.ItemComment{
      # TODO: sanitize it
      content: comment,
      user_id: user_id,
      item_id: item_id,
      created: Ecto.DateTime.local()
    }
    redirect(conn, to: "/item/" <> id <> "/_")
  end

  def preupload(conn, _params) do
    """
    Renders page with image upload widget.
    """
    render conn, "preupload.html"
  end

  def upload(conn, %{"item" => item, "source" => source}) do
    """
    Saves uploaded Item.
    """
    %Plug.Upload{
      content_type: content_type, # "image/png"
      filename: original_name,    # "simple_image.png"
      path: tmp_path              # "/tmp/plug-1431/multipart-989804-534874-2"
    } = item
    
    md5 = get_md5(tmp_path)

    existing_items = Item.find_by_md5(md5)
    case Enum.count(existing_items) do
      count when count > 0 -> 
        existing_items
        |> hd
        |> redirect_to_item(conn)
      _ -> 
        item
        |> insert(md5, source)
        |> save_original(tmp_path)
        |> save_thumb(tmp_path)
        |> redirect_to_item(conn)
    end
  end

  def upload(conn, %{"url" => url}) do
    """
    Fetches Item from web.
    """
    render conn, "preupload.html"
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

  defp insert(item, md5, source) do
    Repo.insert %Item{
      module: "img",
      md5: md5,
      source: source, # TODO: sanitize source
      user_id: 1      # TODO: correct user handling
    }
  end

  defp save_original(item, tmp_path) do
    item_id = Integer.to_string item.id
    File.copy!(tmp_path, 
      @static_path <> "kyon.pl_" <> item_id <> ".jpg",
      :infinity)
    item
  end

  defp save_thumb(item, tmp_path) do
    item_id = Integer.to_string item.id
    Mogrify.open(tmp_path)
    |> Mogrify.resize("200x200^")
    |> Mogrify.save(@static_path <> "thumb_" <> item_id <> ".jpg")
    item
  end

end
