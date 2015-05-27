defmodule Placebooru.PageController do
  use Placebooru.Web, :controller

  plug :action

  def index(conn, _params) do
    # TODO: move it to plug
    conn = assign(conn, :current_user, get_session(conn, :current_user))
    render conn, "index.html"
  end
end
