defmodule Placebooru.ItemFav do
  use Placebooru.Web, :model

  @fav_threshold 1

  schema "item_favs" do
    belongs_to :item, Placebooru.Item
    belongs_to :user, Placebooru.User
  end

  def get_fav_item_ids() do
  	from(i in Placebooru.ItemFav,
  	  group_by: i.item_id,
  	  select: i.item_id,
  	  having: count(i.item_id) >= @fav_threshold
    )
    |> Placebooru.Repo.all
  end

end


"""
CREATE TABLE item_favs (
  id SERIAL,
  item_id INT,
  user_id INT
);

INSERT INTO item_favs (item_id, user_id) VALUES
(13853, 1);
"""
