defmodule Afc.Email do
  import Bamboo.Email

  def share_emotion(emotion_log, emotion) do
    from = Map.fetch!(System.get_env(), "EMAIL_FROM")
    html = emotion_log_to_html(emotion_log, emotion)
    txt = emotion_to_text(emotion_log, emotion)

    new_email()
    |> to(emotion_log.user.trusted_adult.email)
    |> from(from)
    |> subject("New shared emotion log")
    |> html_body(html)
    |> text_body(txt)
  end

  def share_report(user, log, dates) do
    from = Map.fetch!(System.get_env(), "EMAIL_FROM")
    html = report_to_html(user, log, dates)

    new_email()
    |> to(user.trusted_adult.email)
    |> from(from)
    |> subject("New shared report")
    |> html_body(html)
    |> text_body("")
  end

  def emotion_log_to_html(emotion_log, emotion) do
    logged_at = "#{emotion_log.inserted_at.day}-#{emotion_log.inserted_at.month}-#{emotion_log.inserted_at.year}"

    """
    <strong>#{emotion_log.emotion}</strong>
    <p>#{logged_at}</p>
    <p>username: #{emotion_log.user.username}</p>
    <p>reason list:</p>
    #{list_reasons(emotion)}
    <p>reason text:</p>
    <p>#{emotion.reason}</p>
    """
  end

  def report_to_html(user, log, dates) do
    {from, to} = dates
    emotions = emotion_to_report(log)

    """
    <p>Report from #{from} to #{to}</p>
    <p>User: #{user.username}</p>
    <p>#{emotions}</p>
    """
  end

  def list_reasons(log) do
    log
    |> Map.from_struct
    |> Enum.filter(fn {_, v} -> v == true end)
    |> Keyword.keys
    |> Enum.map(fn r ->
      if r == :else do
        "Something else"
      end

      if r == :"family/home" do
        "Family / Home"
      end

      String.capitalize(to_string r)
    end)
    |> Enum.join(", ")
  end

  def emotion_to_text(emotion_log, emotion) do
    """
    #{emotion_log.emotion}
    #{emotion.reason}
    """
  end

  def emotion_to_report(log) do
    log
    |> Enum.map(fn [emotion, count] -> "#{emotion}: #{count}" end)
    |> Enum.join(", ")
  end
end
