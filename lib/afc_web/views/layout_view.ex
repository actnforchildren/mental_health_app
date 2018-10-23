defmodule AfcWeb.LayoutView do
  use AfcWeb, :view

  def background_colour_picker(conn) do
    white_bg_paths = ~w(/emotion/ /sessions)

    if Enum.any?(white_bg_paths, &String.contains?(conn.request_path, &1)) do
      "bg-white"
    else
      "afc-bg-pink"
    end
  end
end
