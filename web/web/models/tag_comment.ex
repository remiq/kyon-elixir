defmodule Placebooru.TagComment do
  use Placebooru.Web, :model
  use Ecto.Model
  alias Placebooru.Repo

  schema "tag_comments" do
    field :content, :string
    field :created, Ecto.DateTime
    belongs_to :tag, Placebooru.Tag
    belongs_to :user, Placebooru.User
  end

  def find_by_tag_id(tag_id) do
    from(tc in Placebooru.TagComment,
      where: tc.tag_id == ^tag_id,
      preload: [:user])
    |> Repo.all
  end

  """
  CREATE TABLE tag_comments (
    id SERIAL,
    tag_id INT,
    user_id INT,
    content TEXT,
    created TIMESTAMP
  );
  INSERT INTO tag_comments (tag_id, user_id, content, created) VALUES
  (1, 1, 'Test comment 1', NOW()),
  (1, 1, 'Test comment 2', NOW()),
  (1, 1, 'Test comment 3', NOW())
  ;
  """
end