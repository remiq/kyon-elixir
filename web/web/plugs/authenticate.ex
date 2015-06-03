defmodule Placebooru.Authenticate do
  import Plug.Conn
  alias Placebooru.LoginInteractor

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    conn
    |> assign(:current_user, LoginInteractor.remind(conn))
  end

end