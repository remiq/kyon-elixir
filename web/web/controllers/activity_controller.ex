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
  end

  def favs_all(conn, %{"page" => page}) do
    """
    Renders list of items favourited by at least one person.
    """
  end

  def favs(conn, %{"page" => page, "user_id" => user_id}) do
    """
    Renders list of items favourited by selected user.
    """
  end

end