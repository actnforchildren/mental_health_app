defmodule AfcWeb.ShareReportController do
  use AfcWeb, :controller
  alias Afc.{Email, Emotion, Mailer, Repo, Emotion.EmotionLog, DateHelper, User}

  def create(conn, params) do
    from = params["from"]
    to = params["to"]
    case DateHelper.parseDates(from, to) do
      %{from: from_date, to: to_date} ->
        logs = Emotion.get_emotion_report(conn.assigns.current_user, from_date, to_date)
        user = Repo.preload(conn.assigns.current_user, :trusted_adult)
        Email.share_report(user, logs, {from, to}) |> Mailer.deliver_now
        redirect conn, to: params["url"]

      _ ->
        redirect conn, to: params["url"]
    end
  end
end
