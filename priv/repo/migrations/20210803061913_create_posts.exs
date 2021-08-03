defmodule LvDemo.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :slug, :string
      add :desc, :string
      add :body, :text
      add :is_published, :boolean, default: false, null: false
      add :blog_id, references(:blogs, on_delete: :nothing)

      timestamps()
    end

    create index(:posts, [:blog_id])
  end
end
