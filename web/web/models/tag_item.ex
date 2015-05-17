defmodule Placebooru.TagItem do
  use Placebooru.Web, :model

  schema "tag_items" do
    belongs_to :item, Placebooru.Item
    belongs_to :tag, Placebooru.Tag
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