defmodule Placebooru.TagController do
  use Placebooru.Web, :controller
  alias Placebooru.Item
  alias Placebooru.Tag

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end

  def all(conn, %{"page" => page}) do
    """
    Displays all Items without filtering them by tag.
    """
    items = Item.find_all page
    render conn, "all.html", items: items
  end

  def single(conn, %{"id" => id_tag, "page" => page}) do
    """
    Displays all Items marked by selected Tag.
    """
    items = Tag.get_item_ids_by_tag_id(id_tag)
      |> Item.find_by_ids(page)
    comments = Placebooru.TagComment.find_by_tag_id(id_tag)
    IO.inspect comments

    render conn, "single.html",
      items: items,
      comments: comments
  end

  def list(conn, _params) do
    """
    Displays JSON of Tag.names matching selected query.
    [API]
    TODO: later
    """

  end



end
