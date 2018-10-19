defmodule AfcWeb.ComponentHelpers do
  alias AfcWeb.ComponentView
  use Phoenix.HTML

  @moduledoc false

  def component(template, assigns) do
    ComponentView.render "#{template}.html", assigns
  end

  def emoji_p_tag(emotion) do
    emoji = string_to_emoji(emotion)
    content_tag(:p, emoji, [class: "emoji-font-size"])
  end

  defp string_to_emoji(emotion) do
    emotion = if is_atom(emotion), do: Atom.to_string(emotion), else: emotion

    emotion
    |> String.downcase()
    |> case do
      "happy" -> "😆"
      "excited" -> "🤩"
      "angry" -> "😡"
      "sad" -> "😭"
      "worried" -> "😬"
      "i don't know" -> "🤔"
      "something else" -> "😶"
    end
  end
end
