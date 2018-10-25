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

  def emotion_log_to_html(emotion_log, emotion) do
    """
    <strong>#{emotion_log.emotion}</strong>
    <p>#{emotion.reason}</p>
    """
  end

  def emotion_to_text(emotion_log, emotion) do
    """
    #{emotion_log.emotion}
    #{emotion.reason}
    """
  end
end
