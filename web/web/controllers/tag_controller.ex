defmodule Placebooru.TagController do
  use Placebooru.Web, :controller
  alias Placebooru.Item
  alias Placebooru.Tag

  def index(conn, _params) do
    render conn, "index.html"
  end

  @doc """
  Displays all Items without filtering them by tag.
  """
  def all(conn, %{"page" => page}) do
    items = Item.find_all page
    render conn, "all.html",
      items: items,
      page: String.to_integer(page)
  end

  @doc """
  Displays all Items marked by selected Tag.
  """
  def single(conn, %{"id" => id_tag, "page" => page}) do
    items = Tag.get_item_ids_by_tag_id(id_tag)
      |> Item.find_by_ids(page)
    comments = Placebooru.TagComment.find_by_tag_id(id_tag)
    IO.inspect comments

    render conn, "single.html",
      items: items,
      comments: comments,
      id_tag: id_tag,
      page: String.to_integer(page)
  end

  @doc """
  Adds a comment and redirects to single/:id
  """
  def comment(conn, %{"id" => id, "comment" => comment}) do
    tag_id = String.to_integer(id)
    %{id: user_id} = Placebooru.LoginInteractor.remind(conn)
    Repo.insert %Placebooru.TagComment{
      # TODO: sanitize it
      content: comment,
      user_id: user_id,
      tag_id: tag_id
    }
    redirect(conn, to: "/tag/" <> id <> "/1/_")
  end

  @doc """
  Displays JSON of Tag.names matching selected query.
  [API]
  TODO: later
  """
  def list(_conn, _params) do


  end



end
