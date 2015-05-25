defmodule Placebooru.TagItem do
  use Placebooru.Web, :model
  use Ecto.Model

  @page_size 40

  schema "tag_items" do
    belongs_to :item, Placebooru.Item
    belongs_to :tag, Placebooru.Tag
  end

  def find_new(page) do
    Placebooru.TagItem
    |> with_tag
    |> with_pagination(page)
    |> Placebooru.Repo.all
  end


  def with_pagination(query, page) do
    offset = (String.to_integer(page) - 1) * @page_size
    from q in query,
    limit: @page_size,
    offset: ^offset
  end

  def with_tag(query) do
    from q in query,
      preload: [:tag]
  end

  """
  CREATE TABLE tag_items (
    id SERIAL,
    item_id INT,
    tag_id INT
  );

  INSERT INTO tag_items (item_id, tag_id) VALUES
  (13853, 1),
  (13853, 2),
  (13853, 3);
  """
end