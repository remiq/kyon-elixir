defmodule Placebooru.ItemComment do
	use Placebooru.Web, :model

	schema "item_comments" do
		field :content, :string
		field :created, Ecto.DateTime
		belongs_to :item, Placebooru.Item
		belongs_to :user, Placebooru.User
	end

  def find_by_item_id(item_id) do
    from(ic in Placebooru.ItemComment,
      where: ic.item_id == ^item_id,
      preload: [:user])
    |> Placebooru.Repo.all
  end
end
