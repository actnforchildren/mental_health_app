defmodule AfcWeb.PageController do
  use AfcWeb, :controller
  alias Afc.{Emotion, Repo}

  def index(conn, _params) do
    case Emotion.todays_emotion_log(conn.assigns.current_user) do
      nil ->
        render conn, "index.html"
      emotion_log ->
        module_name = Emotion.get_emotion_module_name(emotion_log.emotion)
        emotion = Repo.get(module_name, emotion_log.emotion_id)

        render conn, "single.html", emotion_log: emotion_log, emotion: emotion
    end
  end
end
