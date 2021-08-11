defmodule LvDemo.Blogs.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :email, :string
    field :body, :string
    belongs_to :post, LvDemo.Blogs.Post

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :email, :post_id])
    |> validate_required([:body, :email, :post_id])
  end
end
