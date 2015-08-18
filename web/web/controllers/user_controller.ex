defmodule Placebooru.UserController do
  use Placebooru.Web, :controller
  alias Placebooru.LoginInteractor

  def login(conn, post) do
    post
    |> sanitize
    |> Placebooru.User.validate
    |> LoginInteractor.find_or_create
    |> LoginInteractor.authenticate(post["passwd"])
    |> track_login
    |> LoginInteractor.remember(conn)
    |> redirect(to: "/")
  end

  def logout(conn, _params) do
    conn
    |> delete_session(:current_user)
    |> redirect(to: "/")
  end

  defp track_login(post) do
    %{name: name} = post
    SlackWebhook.send "User #{name} logged in!"
    post
  end

  defp sanitize(post) do
    # %{"name", "passwd"}
    post
    |> Enum.reduce(%{}, fn {k, v}, acc ->
      Map.put(acc, k, HtmlSanitizeEx.strip_tags(v))
    end)
  end
end
