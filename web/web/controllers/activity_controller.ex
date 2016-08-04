defmodule Placebooru.ActivityController do
  use Placebooru.Web, :controller

  @doc """
  Renders list of recent comments.
  """
  def comments(conn, %{"page" => page}) do
    render conn, "comments.html",
      comments: Placebooru.ViewComment.find_new(page)
  end

  @doc """
  Renders list of recently added tags
  """
  def tags(conn, %{"page" => page}) do
    render conn, "tags.html",
      tag_items: Placebooru.TagItem.find_new(page),
      page: String.to_integer(page)
  end

  @doc """
  Renders list of items favourited by at least one person.
  """
  def favs_all(conn, %{"page" => page}) do
    fav_ids = Placebooru.ItemFav.get_fav_item_ids()
    render conn, "favs.html",
      items: Placebooru.Item.find_by_ids(fav_ids, page),
      page: String.to_integer(page)
  end

  @doc """
  Renders list of items favourited by selected user.
  """
  def favs(_conn, %{"page" => _page, "user_id" => _user_id}) do
    # TODO
  end

end
