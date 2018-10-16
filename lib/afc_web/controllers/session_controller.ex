defmodule AfcWeb.SessionController do
  use AfcWeb, :controller
  alias AfcWeb.Auth
  alias Afc.{Repo, User}

  def new(conn, _params) do
    if conn.assigns.current_user do
      redirect(conn, to: page_path(conn, :index))
    else
      render(conn, "new.html")
    end
  end

  def create(conn, _params) do
    user = Repo.get_by!(User, username: "test_user")

    conn
    |> Auth.login(user)
    |> redirect(to: page_path(conn, :index))
  end

  def delete(conn, _params) do
    conn
    |> Auth.logout()
    |> redirect(to: session_path(conn, :new))
  end
end
