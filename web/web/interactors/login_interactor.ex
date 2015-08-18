defmodule Placebooru.LoginInteractor do
  import Phoenix.Controller, only: [put_flash: 3]
  import Plug.Conn
  alias Placebooru.Repo
  alias Placebooru.User

  @derivation Comeonin.Pbkdf2

  def find_or_create({:error, message}) do
    {:error, message}
  end

  def find_or_create(%{name: name, passwd: passwd}) do
    case Repo.get_by User, name: name do
      nil -> register(%{name: name, passwd: passwd})
      user -> user
    end
  end

  def register(%{name: name, passwd: passwd}) do
    hash = @derivation.hashpwsalt passwd
    {:ok, user} = Repo.insert %User{
      name: name,
      passwd: hash
    }
    user
  end

  def authenticate({:error, message}, _) do
    {:error, message}
  end

  def authenticate(user, passwd) do
    if @derivation.checkpw passwd, user.passwd do
      user
    else
      {:error, "Invalid password"}
    end
  end

  def remember({:error, message}, conn) do
    conn |> put_flash(:error, message)
  end

  def remember(user, conn) do
    conn |> put_session(:current_user, %{
      id: user.id,
      name: user.name
    })
  end

  def remind(conn) do
    conn |> get_session(:current_user)
  end
end
