defmodule LvDemo.Blogs.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :email, :string
    field :title, :string
    belongs_to :post, LvDemo.Blogs.Post

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:title, :email])
    |> validate_required([:title, :email])
  end
end
