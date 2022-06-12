defmodule Mellifera.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :name, :string
    field :email, :string

    field :roles, Ecto.Enum,
      values: [
        # internal users
        :admin,
        :grader,
        :observer,
        :registrar,
        :payment__verifier,
        # external users
        :participant,
        :group_supervisor
      ]

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :phone])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
    |> unique_constraint(:phone)
  end
end
