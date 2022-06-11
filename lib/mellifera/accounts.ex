defmodule Mellifera.Accounts do
  import Ecto.Query, warn: false

  alias Mellifera.Repo
  alias Mellifera.Accounts.User
  alias Mellifera.Accounts.Login

  def list_users do
    Repo.all(User)
  end

  def fetch_user(id), do: Repo.get(User, id)
  def fetch_user(:email, email), do: User |> where([u], u.email == ^email) |> Repo.one()

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

  def fetch_or_create(uid, %{email: _email} = _attrs) do
    Repo.transaction(fn ->
      case Repo.get(Login, uid) do
        %Login{user_id: user_id} ->
          User |> Repo.get(user_id)

        nil ->
          nil
          # case fetch_user(:email, email) do
          #   nil ->
          #     nil
          # end
      end
    end)
  end
end
