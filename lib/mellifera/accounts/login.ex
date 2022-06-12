defmodule Mellifera.Accounts.Login do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "logins" do
    field :uid, :string
    field :user, :binary_id
    field :extra, :map, redact: true

    timestamps()
  end

  @doc false
  def changeset(login, attrs) do
    login
    |> cast(attrs, [:uid, :extra])
    |> validate_required([:uid, :extra])
    |> unique_constraint(:uid)
  end
end
