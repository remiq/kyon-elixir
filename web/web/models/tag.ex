defmodule Placebooru.Tag do
  use Placebooru.Web, :model
  use Ecto.Model

  schema "tags" do
    field :name, :string
    field :synonym_id, :integer
  end

  def for_item(id_item) do
    query = from ti in Placebooru.TagItem,
    where: ti.item_id == ^id_item,
    preload: [:tag]
    Placebooru.Repo.all query
  end

  """
  INSERT INTO tags (id, name) VALUES
  (1, 'aaa'),
  (2, 'bbb'),
  (3, 'ccc');
  """

end