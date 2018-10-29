defmodule AfcWeb.LogController do
  use AfcWeb, :controller
  alias Afc.{Emotion, Repo}

  def index(conn, params) do
    date = params["date"]
    case Timex.parse(date, "%d-%m-%Y", :strftime) do
      {:ok, date} ->
        selected_date = Timex.to_unix date
        current_date = Timex.to_unix Timex.now
        if (selected_date > current_date) do
          render conn, "error.html"
        else
          today = Timex.today |> Timex.to_unix
          case Emotion.get_emotion_log_for_date(conn.assigns.current_user, date) do
            nil ->
              if today == selected_date do
                redirect conn, to: page_path(conn, :index)
              else
                date_title = Timex.format!(date, "{WDfull} {D} {Mfull}")
                render conn, "no_emotion_logged.html", millis: selected_date * 1000, date_title: date_title
              end
            emotion_log ->
              module_name = Emotion.get_emotion_module_name(emotion_log.emotion)
              emotion = Repo.get(module_name, emotion_log.emotion_id)
              date_title = if today === selected_date do
                  "Today's Log"
                else
                  Timex.format!(date, "{WDfull} {D} {Mfull}")
                end
              render conn, "single.html",
                emotion_log: emotion_log,
                emotion: emotion,
                millis: selected_date * 1000,
                date_title: date_title,
                date: params["date"]
          end
        end
      _ ->
        render conn, "error.html"
    end
  end
end
