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
    case Keyword.fetch(opts, :class) do
      {:ok, classes} ->
        opts = Keyword.delete(opts, :class)
        content_tag(:img, "", [class: "w4 " <> classes, src: src] ++ opts)
      :error ->
        content_tag(:img, "", [class: "w4 ", src: src] ++ opts)
    end
  end

  def render_emotion_reason(emotion, conn) do
    positive_reasons = ["happy", "excited"]

    if Enum.any?(positive_reasons, &(&1 == emotion)) do
      component("positive_emotion_reason", emotion: emotion, conn: conn)
    else
      component("negative_emotion_reason", emotion: emotion, conn: conn)
    end
  end
end
