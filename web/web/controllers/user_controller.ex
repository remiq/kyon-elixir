defmodule Placebooru.UserController do
  use Placebooru.Web, :controller
  alias Placebooru.LoginInteractor

  plug :action

  def login(conn, post) do
    post
    |> Placebooru.User.validate
    |> LoginInteractor.find_or_create
    |> LoginInteractor.authenticate(post["passwd"])
    |> LoginInteractor.remember(conn)
    |> redirect(to: "/")
  end

  def logout(conn, _params) do
    conn
    |> delete_session(:current_user)
    |> redirect(to: "/")
  end

end