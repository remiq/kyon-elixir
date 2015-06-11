defmodule Placebooru.Authenticate do
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3]
  alias Placebooru.LoginInteractor

  def init(opts \\ :anybody) do
    opts
  end

  def call(conn, opts) do
    IO.inspect opts
    user = LoginInteractor.remind(conn)
    IO.inspect user
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