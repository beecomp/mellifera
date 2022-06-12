defmodule Mellifera.Repo.Migrations.Init do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :email, :string
      add :roles, {:array, :string}

      timestamps()
    end

    create unique_index(:users, [:email])

    create table(:logins, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :uid, :string
      add :extra, :map
      add :user, references(:users, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create unique_index(:logins, [:uid])
    create index(:logins, [:user])
  end
end
