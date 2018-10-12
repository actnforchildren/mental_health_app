defmodule AfcWeb.ComponentHelpers do
  alias AfcWeb.ComponentView

  def component(template, assigns) do
    ComponentView.render "#{template}.html", assigns
  end
end
