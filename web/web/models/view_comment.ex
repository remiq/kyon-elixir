defmodule Placebooru.ViewComment do
  use Placebooru.Web, :model
  use Ecto.Model

  @page_size 20
  @primary_key false

  schema "view_comments" do
    field :type, :string
    field :ref_id, :integer
    field :content, :string
    field :created, :datetime
    field :user_id, :integer # no id -> no relations
  end

  def find_new(page) do
    Placebooru.ViewComment
    |> with_pagination(page)
    |> Placebooru.Repo.all
  end

  def with_pagination(query, page) do
    offset = (String.to_integer(page) - 1) * @page_size
    from q in query,
    limit: @page_size,
    offset: ^offset
  end

end
