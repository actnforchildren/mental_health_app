defmodule AfcWeb.PageController do
  use AfcWeb, :controller
  alias Afc.{Emotion, Repo}

  def index(conn, _params) do
    case Emotion.todays_emotion_log(conn.assigns.current_user) do
      nil ->
        render conn, "index.html", millis: (Timex.to_unix Timex.now) * 1000
      _ ->
        now = Timex.now
        query_string = Timex.format!(now, "{0D}-{0M}-{YYYY}")
        redirect conn, to: log_path(conn, :index, %{date: query_string})
    end
  end
end
