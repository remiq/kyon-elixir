defmodule Placebooru.Tag do
  use Placebooru.Web, :model
  use Ecto.Model
  alias Placebooru.Repo
  alias Placebooru.TagItem

  schema "tags" do
    field :name, :string
    field :synonym_id, :integer
  end

  def for_item(id_item) do
    TagItem
    |> where_item(id_item)
    |> with_tag
    |> Repo.all
  end

  def get_item_ids_by_tag_id(id_tag) do
    TagItem
    |> where_tag(id_tag)
    |> Repo.all
    |> Enum.map(fn(ti) -> ti.item_id end)
  end

  def where_tag(query, id_tag) do
    from q in query,
      where: q.tag_id == ^id_tag
  end

  def where_item(query, id_item) do
    from q in query,
      where: q.item_id == ^id_item
  end

  def with_tag(query) do
    from q in query,
      preload: [:tag]
  end

  def insert_by_name(name, item_id, _user_id) do
    # TODO: name should be case-insensitive
    tag = Repo.get_by(__MODULE__, name: name)
    if (tag == nil) do
      {:ok, tag} = Repo.insert %__MODULE__{
        name: name
      }
    end
    IO.inspect(tag)
    # TODO: check for synonyms
    tag_id = tag.id
    Repo.insert %TagItem{
      item_id: item_id,
      tag_id: tag_id
      # TODO: tag marking should be auditable by user_id
    }
  end

  

  """
  INSERT INTO tags (id, name) VALUES
  (1, 'aaa'),
  (2, 'bbb'),
  (3, 'ccc');
  """

end
