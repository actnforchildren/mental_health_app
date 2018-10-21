defmodule AfcWeb.ComponentHelpers do
  alias AfcWeb.ComponentView
  use Phoenix.HTML

  @moduledoc false

  def component(template, assigns \\ []) do
    ComponentView.render "#{template}.html", assigns
  end

  def emoji_p_tag(emotion, opts \\ []) do
    emoji = string_to_emoji(emotion)

    case Keyword.fetch(opts, :class) do
      {:ok, classes} ->
        opts = Keyword.delete(opts, :class)
        content_tag(:p, emoji, [class: "emoji-font-size " <> classes] ++ opts)
      :error ->
        content_tag(:p, emoji, [class: "emoji-font-size"] ++ opts)
    end
  end

  def render_emotion_reason(emotion) do
    positive_reasons = ["happy", "excited"]
    negative_reasons = ["angry", "sad", "worried"]

    cond do
      Enum.any?(positive_reasons, &(&1 == emotion)) ->
        component("positive_emotion_reason", emotion: emotion)
      Enum.any?(negative_reasons, &(&1 == emotion)) ->
        component("negative_emotion_reason", emotion: emotion)
    end
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
