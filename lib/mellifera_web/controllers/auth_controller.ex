defmodule MelliferaWeb.AuthController do
  use MelliferaWeb, :controller
  plug Ueberauth

  # alias Mellifera.Accounts
  alias Ueberauth.Strategy.Helpers

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    IO.inspect(auth)

    conn
    |> put_flash(:info, "hello!")
    |> redirect(to: "/")

    # user = Accounts.fetch_or_create(auth)
    # conn
    # |> put_flash(:info, "Successfully authenticated.")
    # |> put_session(:current_user, user)
    # |> configure_session(renew: true)
    # |> redirect(to: "/")

    # case Accounts.fetch_or_create(auth) do
    #   {:ok, user} ->

    #   {:error, reason} ->
    #     conn
    #     |> put_flash(:error, reason)
    #     |> redirect(to: "/")
    # end
  end

  def logout(conn, _params) do
    conn
    |> clear_session()
    |> redirect(to: "/")
  end
end
