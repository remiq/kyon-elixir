defmodule Placebooru.ActivityController do
  use Placebooru.Web, :controller

  plug :action

  def comments(conn, %{"page" => page}) do
    """
    Renders list of recent comments.
    """
    render conn, "comments.html",
      comments: Placebooru.ViewComment.find_new(page)
  end

  def tags(conn, %{"page" => page}) do
    """
    Renders list of recently added tags
    """
    render conn, "tags.html",
      tag_items: Placebooru.TagItem.find_new(page),
      page: String.to_integer(page)
  end

  def favs_all(conn, %{"page" => page}) do
    """
    Renders list of items favourited by at least one person.
    """
    fav_ids = Placebooru.ItemFav.get_fav_item_ids()
    IO.inspect(fav_ids)
    render conn, "favs.html",
      items: Placebooru.Item.find_by_ids(fav_ids, page),
      page: String.to_integer(page)
  end

  def favs(conn, %{"page" => page, "user_id" => user_id}) do
    """
    Renders list of items favourited by selected user.
    """
  end

end