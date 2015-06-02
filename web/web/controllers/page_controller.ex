defmodule Placebooru.PageController do
  use Placebooru.Web, :controller

  plug :action

  def index(conn, _params) do
    # TODO: move it to plug
    user = get_session(conn, :current_user)
    IO.inspect user
    conn = assign(conn, :current_user, user)
    render conn, "index.html"
  end
end
