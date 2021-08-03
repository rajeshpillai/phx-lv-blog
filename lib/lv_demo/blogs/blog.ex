defmodule LvDemo.Blogs.Blog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "blogs" do
    field :desc, :string
    field :is_published, :boolean, default: false
    field :name, :string
    field :slug, :string
    field :url, :string
    has_many :posts, LvDemo.Blogs.Post
    timestamps()
  end

  @doc false
  def changeset(blog, attrs) do
    blog
    |> cast(attrs, [:name, :slug, :desc, :url, :is_published])
    |> validate_required([:name, :slug, :desc, :url, :is_published])
  end
end
