defmodule AfcWeb.Auth do
  import Plug.Conn
  import Phoenix.Controller
  alias Afc.{Repo, User}
  alias AfcWeb.Router.Helpers

  @moduledoc """
  Auth module
  """

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && Repo.get(User, user_id)
    assign(conn, :current_user, user)
  end

  def login_with_username_and_pin(conn, username, pin) do
    user = Repo.get_by(User, username: username)

    case System.get_env("LOGIN_ENABLE") do
      "true" ->
        if user && user.pin == pin do
          {:ok, login(conn, user)}
        else
          {:error, conn}
        end

      _ ->
        if user && user.pin == pin && String.starts_with?(username, "test") do
          {:ok, login(conn, user)}
        else
          {:error, conn}
        end
    end
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def logout(conn), do: configure_session(conn, drop: true)

  def authenticate_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Helpers.session_path(conn, :new))
      |> halt()
    end
  end
end
