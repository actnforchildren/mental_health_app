defmodule AfcWeb.SessionController do
  use AfcWeb, :controller
  alias AfcWeb.Auth

  def new(conn, _params) do
    if conn.assigns.current_user do
      redirect(conn, to: page_path(conn, :index))
    else
      render(conn, "new.html")
    end
  end

  def create(conn, %{"session" => %{"username" => username, "pin1" => pin1, "pin2" => pin2, "pin3" => pin3, "pin4" => pin4}}) do
    pin = "#{pin1}#{pin2}#{pin3}#{pin4}"

    case Integer.parse(pin) do
      {pin, ""} ->
        case Auth.login_with_username_and_pin(conn, username, pin) do
          {:ok, conn} ->
            redirect(conn, to: page_path(conn, :index))

          {:error, conn} ->
            conn
            |> put_flash(:error, "You have entered an invalid username or password")
            |> render("new.html")
        end

      _ ->
        conn
        |> put_flash(:error, "You have entered an invalid username or password")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> Auth.logout()
    |> redirect(to: session_path(conn, :new))
  end
end
