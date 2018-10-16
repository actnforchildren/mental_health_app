defmodule AfcWeb.EmotionController do
  use AfcWeb, :controller
  alias Afc.{Angry, Happy, Repo}

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
      {:ok, _captured_emotion} ->

        # The emotion itself has been captured at this point. Next step
        # is to insert into the emotion_log table.
        render conn, "captured.html"

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
