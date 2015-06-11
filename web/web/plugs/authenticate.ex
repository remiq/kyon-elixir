defmodule Placebooru.Authenticate do
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3]
  alias Placebooru.LoginInteractor

  def init(opts \\ :anybody) do
    opts
  end

  def call(conn, opts) do
    user = LoginInteractor.remind(conn)
    if !user && opts != :anybody do
      conn 
      |> put_flash(:error, "This function is only for Members!")
      |> Phoenix.Controller.redirect(to: "/") 
      |> halt
    else 
      conn
      |> assign(:current_user, user)
    end
  end

end