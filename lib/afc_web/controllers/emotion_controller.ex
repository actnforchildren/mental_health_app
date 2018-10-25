defmodule AfcWeb.EmotionController do
  use AfcWeb, :controller
  alias Afc.Emotion
  alias Afc.Emotion.{EmotionLog}
  alias Afc.Repo
  alias Ecto.Changeset

  def show(conn, %{"id" => "captured"}) do
    render conn, "captured.html"
  end

  def show(conn, %{"id" => emotion_str}) do
    emotion_map = Emotion.get_emotion_map(emotion_str)
    module_struct = emotion_str |> Emotion.get_emotion_module_name() |> struct()
    changeset = emotion_map.module.changeset(module_struct, %{})
    form_page = pick_emotion_form(emotion_str)
    render conn, form_page, changeset: changeset, module: emotion_map.module, emotion: emotion_str
  end

  def create(conn, params) do
    emotion_str = get_submitted_emotion(params)
    form_info = Map.get(params, emotion_str)
    emotion_map = Emotion.get_emotion_map(emotion_str)
    module_struct = emotion_str |> Emotion.get_emotion_module_name() |> struct()
    changeset = emotion_map.module.changeset(module_struct, form_info)

    case Repo.insert(changeset) do
      {:ok, captured_emotion} ->
        emotion_params =
          %{emotion: emotion_str, emotion_id: captured_emotion.id}

        log = %EmotionLog{}
        |> EmotionLog.changeset(emotion_params)
        |> Changeset.put_assoc(:user, conn.assigns.current_user)
        |> Repo.insert!()

        date = Timex.format!(Timex.now(), "{0D}-{0M}-{YYYY}")
        render conn, "captured.html", log_id: log.id, date: date
        # redirect(conn, to: emotion_path(conn, :show, "captured"))

      {:error, changeset} ->
        assigns = [changeset: changeset, module: emotion_map.module]
        render conn, "form.html", assigns
    end
  end

  defp get_submitted_emotion(params) do
    Emotion.emotion_list
    |> Enum.map(&Atom.to_string/1)
    |> Enum.filter(&(Map.has_key?(params, &1)))
    |> hd()
  end

  defp pick_emotion_form(emotion_str) do
    pos_neg_emotions = ["happy", "excited", "angry", "sad", "worried"]
    cond do
      Enum.any?(pos_neg_emotions, &(&1 == emotion_str)) ->
        "positive_negative_form.html"
      emotion_str == "else" ->
        "else_form.html"
      true ->
        "unsure_form.html"
    end
  end
end
