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
    module_atom = Emotion.get_emotion_module_atom(emotion_str)
    module_struct = struct(module_atom)
    changeset = emotion_map.module.changeset(module_struct, %{})
    render conn, "form.html", changeset: changeset, module: emotion_map.module
  end

  def create(conn, params) do
    emotion_str = get_submitted_emotion(params)
    form_info = Map.get(params, emotion_str)
    emotion_map = Emotion.get_emotion_map(emotion_str)
    module_atom = Emotion.get_emotion_module_atom(emotion_str)
    module_struct = struct(module_atom)
    changeset = emotion_map.module.changeset(module_struct, form_info)

    case Repo.insert(changeset) do
      {:ok, captured_emotion} ->
        emotion_params =
          %{emotion: emotion_str, emotion_id: captured_emotion.id}

        %EmotionLog{}
        |> EmotionLog.changeset(emotion_params)
        |> Changeset.put_assoc(:user, conn.assigns.current_user)
        |> Repo.insert!()

        redirect(conn, to: emotion_path(conn, :show, "captured"))

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
end
