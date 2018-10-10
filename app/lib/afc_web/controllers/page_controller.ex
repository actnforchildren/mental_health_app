defmodule AfcWeb.PageController do
  use AfcWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
