defmodule AfcWeb.LogController do
  use AfcWeb, :controller
  alias Afc.{Emotion, Repo}
  require Logger

  def index(conn, params) do
    date = params["date"]
    case Timex.parse(date, "%d-%m-%Y", :strftime) do
      {:ok, date} ->
        selected_date = Timex.to_unix date
        current_date = Timex.to_unix Timex.now
        if (selected_date > current_date) do
          render conn, "error.html"
        else
          case Emotion.get_emotion_log_for_date(conn.assigns.current_user, date) do
            nil ->
              render conn, "new.html", millis: selected_date * 1000
              emotion_log ->
                module_name = Emotion.get_emotion_module_name(emotion_log.emotion)
                emotion = Repo.get(module_name, emotion_log.emotion_id)
                render conn, "single.html", emotion_log: emotion_log, emotion: emotion, millis: selected_date * 1000
          end
        end
      _ ->
        render conn, "error.html"
    end
  end
end
