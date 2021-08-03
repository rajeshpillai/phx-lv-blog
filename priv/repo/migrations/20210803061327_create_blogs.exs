defmodule LvDemo.Repo.Migrations.CreateBlogs do
  use Ecto.Migration

  def change do
    create table(:blogs) do
      add :name, :string
      add :slug, :string
      add :desc, :text
      add :url, :string
      add :is_published, :boolean, default: false, null: false

      timestamps()
    end

  end
end
