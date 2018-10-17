defmodule AfcWeb.PageController do
  use AfcWeb, :controller
  alias Afc.Emotion

  def index(conn, _params) do
    case Emotion.todays_logged_emotion(conn.assigns.current_user) do
      nil ->
        render conn, "index.html"
      emotion ->
        render conn, "single.html", emotion: emotion
    end
  end
end
