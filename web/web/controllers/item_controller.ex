defmodule Placebooru.ItemController do
  use Placebooru.Web, :controller
  alias Placebooru.Item
  alias Placebooru.Tag

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
      comments: []
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
    # TODO: create record in db, get new id
    File.copy!(tmp_path, @static_path <> "kyon.pl_X.jpg", :infinity)
    Mogrify.open(tmp_path)
    |> Mogrify.resize("200x200^")
    |> Mogrify.save(@static_path <> "thumb_" <> ".jpg")
    render conn, "preupload.html"
  end

  def upload(conn, %{"url" => url}) do
    """
    Fetches Item from web.
    """
    render conn, "preupload.html"
  end

end
