defmodule LvDemo.Blogs.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :desc, :string
    field :is_published, :boolean, default: false
    field :slug, :string
    field :title, :string
    field :body, :string
    # field :blog_id, :id
    belongs_to :blog, LvDemo.Blogs.Blog
    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :slug, :desc, :is_published, :blog_id, :body])
    |> validate_required([:title, :slug, :desc, :is_published])
  end
end

