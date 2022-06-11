defmodule Mellifera.Repo.Migrations.CreateLogins do
  use Ecto.Migration

  def change do
    create table(:logins, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :uid, :string
      add :extra, :map
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create unique_index(:logins, [:uid])
    create index(:logins, [:user_id])
  end
end
