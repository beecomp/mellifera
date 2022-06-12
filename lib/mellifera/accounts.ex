defmodule Mellifera.Accounts do
  import Ecto.Query, warn: false

  alias __MODULE__
  alias Mellifera.Repo
  alias Mellifera.Accounts.User
  alias Mellifera.Accounts.Login

  def list_users do
    Repo.all(User)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def fetch_or_create([uid: uid], %{email: email} = attrs) do
    case Login |> Repo.get_by(uid: uid) do
      %Login{user: user} ->
        User |> Repo.get(user)

      nil ->
        user =
          case User |> Repo.get_by(email: email) do
            %User{} = user -> user
            nil -> %User{} |> User.changeset(attrs) |> Repo.insert!()
          end

        %Login{}
        |> Login.changeset(%{uid: uid, email: email, extra: %{}, user: user})
        |> Repo.insert()
    end
  end
end
