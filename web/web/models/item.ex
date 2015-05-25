defmodule Placebooru.Item do
  use Placebooru.Web, :model
  use Ecto.Model
  alias Placebooru.Repo

  @page_size 20
  

  schema "items" do
    field :module, :string
    field :md5, :string
    field :source, :string
    # created

    belongs_to :user, Placebooru.User
    has_many :tags, Placebooru.Tag
  end

  def find_all(page) do
    Placebooru.Item
    |> with_pagination(page)
    |> Repo.all
  end

  def find_by_ids(item_ids, page) do
    Placebooru.Item
    |> where_ids(item_ids)
    |> with_pagination(page)
    |> Repo.all
  end

  def find_by_id(id) do
    Placebooru.Item
    |> with_user
    |> Repo.get id
  end

  def find_by_md5(md5) do
    Placebooru.Item
    |> where_md5(md5)
    |> Repo.all
  end

  def with_user(query) do
    from q in query,
    preload: [:user]
  end

  def with_pagination(query, page) do
    offset = (String.to_integer(page) - 1) * @page_size
    from q in query,
    limit: @page_size,
    offset: ^offset
  end

  def where_ids(query, item_ids) do
    from q in query,
      where: q.id in ^item_ids
  end

  def where_md5(query, md5) do
    from q in query,
      where: q.md5 == ^md5
  end

  """
  INSERT INTO items (id, module, user_id, md5, source, created) VALUES (13853, 'img', 1, '123', 'http://source/url', now())
  """

end
