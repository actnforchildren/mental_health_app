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

  def format_emotion_name(emotion) do
    case emotion do
      :else -> "Something else"
      :unsure -> "I don't know"
      _ ->  emotion
            |> Atom.to_string()
            |> String.capitalize()
    end
  end
end
