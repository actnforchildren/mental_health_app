defmodule AfcWeb.LayoutView do
  use AfcWeb, :view

  def background_colour_picker(conn) do
    if String.contains?(conn.request_path, "/emotion/") do
      "bg-white"
    else
      "afc-bg-pink"
    end
  end
end
