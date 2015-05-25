defmodule Placebooru.ViewComment do
  use Placebooru.Web, :model
  use Ecto.Model

  @page_size 20
  @primary_key {:id, :string, []}

  schema "view_comments" do
    field :type, :string
    field :ref_id, :integer
    field :content, :string
    field :created, :datetime
    belongs_to :user, Placebooru.User
  end

  def find_new(page) do
    Placebooru.ViewComment
    |> with_user
    |> with_pagination(page)
    |> Placebooru.Repo.all
  end

  defp with_user(query) do
    from q in query,
      preload: [:user]
  end

  def with_pagination(query, page) do
    offset = (String.to_integer(page) - 1) * @page_size
    from q in query,
    limit: @page_size,
    offset: ^offset
  end

end