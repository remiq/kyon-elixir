defmodule Placebooru.PageController do
  use Placebooru.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end