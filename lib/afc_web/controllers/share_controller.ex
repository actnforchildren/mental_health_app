defmodule AfcWeb.ShareController do
  use AfcWeb, :controller
  alias Afc.{Email, Emotion, Mailer, Repo, Emotion.EmotionLog}

  def create(conn, params) do
    id = params["emotion_log_id"]
    date = params["date"]
    case log = Repo.get(EmotionLog, id) |> Repo.preload([user: :trusted_adult]) do
      nil -> redirect conn, to: log_path(conn, :index, %{date: date})
      _  ->
        emotionSchema = log.emotion |> Emotion.get_emotion_module_name()
        case emotion = Repo.get(emotionSchema, log.emotion_id) do
          nil -> redirect conn, to: log_path(conn, :index, %{date: date})
          _ ->
            Email.share_emotion(log, emotion) |> Mailer.deliver_now
            changeset = EmotionLog.changeset log, %{shared: true}
            Repo.update(changeset)
            redirect conn, to: log_path(conn, :index, %{date: date})
        end
    end
  end



end
