defmodule Placebooru.User do
  use Placebooru.Web, :model
  use Ecto.Model

  schema "users" do
    field :name, :string
    field :passwd, :string
    field :status, :integer
  end

  def validate(%{"name" => name, "passwd" => passwd}) do
    cond do
      String.length(name) < 2 -> {:error, "Name too short"}
      String.length(passwd) < 2 -> {:error, "Pass too short"}
      true -> %{name: name, passwd: passwd}
    end
  end

  """
  INSERT INTO users (id, name) VALUES (1, 'testuser')
  """

end