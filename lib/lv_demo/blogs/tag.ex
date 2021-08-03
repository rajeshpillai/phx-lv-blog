defmodule LvDemo.Blogs.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tags" do
    field :title, :string
    many_to_many :posts, LvDemo.Blogs.Post, join_through: "posts_tags"
    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
