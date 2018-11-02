defmodule AfcWeb.ComponentHelpers do
  alias AfcWeb.ComponentView
  use Phoenix.HTML

  @moduledoc false

  def component(template, assigns \\ []) do
    ComponentView.render "#{template}.html", assigns
  end

  def src_image(image) do
    image = if is_atom(image), do: Atom.to_string(image), else: image
    "/images/" <> image <> ".png"
  end

  def emoji_img_tag(src, opts \\ []) do
    content_tag(:img, "", [src: src] ++ opts)
  end

  def render_emotion_reason(emotion, conn) do
    positive_reasons = ["happy", "excited"]

    if Enum.any?(positive_reasons, &(&1 == emotion)) do
      component("positive_emotion_reason", emotion: emotion, conn: conn)
    else
      component("negative_emotion_reason", emotion: emotion, conn: conn)
    end
  end

  def pick_toolbox(emotion) do
    case emotion do
      "angry" -> "toolbox_anger"
      "sad" -> "toolbox_sadness"
      "worried" -> "toolbox_worry"
    end
  end

  def display_nav_dot(conn, nav_name) do
    path = nav_dot_helper(conn)

    if path == nav_name, do: "afc-bg-red", else: ""
  end

  defp nav_dot_helper(conn) do
    toolbox_paths =  ~w(/toolbox /info)

    cond do
      Enum.any?(toolbox_paths, &String.contains?(conn.request_path, &1)) ->
        "toolbox"
      String.contains?(conn.request_path, "/help") ->
        "help"
      true ->
        "home"
    end
  end
end
