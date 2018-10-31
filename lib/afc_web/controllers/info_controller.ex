defmodule AfcWeb.InfoController do
  use AfcWeb, :controller

  def show(conn, %{"id" => page}) do
    static_pages = ~w(what_is_mental_wellbeing mental_wellbeing_vs_mental_health what_is_change the_impact_of_change)
    case Enum.any?(static_pages, &(&1 == page)) do
      true ->
        render conn, "#{page}.html"
      false ->
        render conn, "not_found.html"
    end
  end
end
