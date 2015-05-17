defmodule Placebooru.User do
  use Placebooru.Web, :model

  schema "users" do
    field :name, :string
    field :status, :integer
  end

  """
  INSERT INTO users (id, name) VALUES (1, 'testuser')
  """

end