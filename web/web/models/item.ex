defmodule Placebooru.Item do
  use Placebooru.Web, :model
  use Ecto.Model

  schema "items" do
    field :module, :string
    field :md5, :string
    field :source, :string
    # created

    belongs_to :user, Placebooru.User
    has_many :tags, Placebooru.Tag
  end

  def find_by_id(id) do
    Placebooru.Item
    |> with_user
    |> Placebooru.Repo.get id
  end

  def with_user(query) do
    from q in query,
    preload: [:user]
  end

  """
  INSERT INTO items (id, module, user_id, md5, source, created) VALUES (13853, 'img', 1, '123', 'http://source/url', now())
  """

end