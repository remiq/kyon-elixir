defmodule Placebooru.Authenticate do
  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    user = get_session(conn, :current_user)
    conn
    |> assign(:current_user, user)
  end

end