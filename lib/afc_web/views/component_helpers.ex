defmodule AfcWeb.ComponentHelpers do
  alias AfcWeb.ComponentView
  use Phoenix.HTML

  @moduledoc false

  def component(template, assigns) do
    ComponentView.render "#{template}.html", assigns
  end

  def emoji_p_tag(emoji) do
    content_tag(:p, emoji, [class: "emoji-font-size"])
  end
end
