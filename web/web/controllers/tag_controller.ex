defmodule Placebooru.TagController do
  use Placebooru.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end

  def all(conn, %{"page" => page}) do
    """
    Displays all Items without filtering them by tag.
    """
  end

  def single(conn, %{"id" => id_tag, "page" => page}) do
    """
    Displays all Items marked by selected Tag.
    """
  end

  def list(conn, _params) do
    """
    Displays JSON of Tag.names matching selected query.
    [API]
    TODO: later
    """

  end



end
