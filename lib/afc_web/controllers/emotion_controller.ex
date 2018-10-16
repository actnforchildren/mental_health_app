defmodule AfcWeb.EmotionController do
  use AfcWeb, :controller
  alias Afc.{Angry, EmotionLog, Happy, Repo}
  alias Ecto.Changeset

  def show(conn, %{"id" => "captured"}) do
    render conn, "captured.html"
  end

  def show(conn, %{"id" => emotion}) do
    {module, changeset} = get_page_module_and_changeset(emotion)

    render conn, "form.html", changeset: changeset, module: module
  end

  def create(conn, params) do
    submitted_emotion =
      ~w(angry happy)
      |> Enum.filter(&(Map.has_key?(params, &1)))
      |> hd()

    form_info = Map.get(params, submitted_emotion)

    {module, changeset} =
      get_page_module_and_changeset(submitted_emotion, form_info)

    case Repo.insert(changeset) do
      {:ok, captured_emotion} ->
        emotion_params =
          %{emotion: submitted_emotion, emotion_id: captured_emotion.id}

        %EmotionLog{}
        |> EmotionLog.changeset(emotion_params)
        |> Changeset.put_assoc(:user, conn.assigns.current_user)
        |> Repo.insert!()

        redirect(conn, to: emotion_path(conn, :show, "captured"))

      {:error, changeset} ->
        render conn, "form.html", changeset: changeset, module: module
    end
  end

  defp get_page_module_and_changeset(page, params \\ %{}) do
    case page do
      "happy" ->
        {Happy, Happy.changeset(%Happy{}, params)}
      "angry" ->
        {Angry, Angry.changeset(%Angry{}, params)}
    end
  end
end
