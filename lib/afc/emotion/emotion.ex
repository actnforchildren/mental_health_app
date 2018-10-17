defmodule Afc.Emotion do
  alias Afc.Repo
  alias Afc.Emotion.EmotionLog
  import Ecto.Query
  use Timex

  def todays_logged_emotion(user) do
    start_of_today = Timex.today() |> Timex.to_naive_datetime()

    query =
      from e in EmotionLog,
      where: e.user_id == ^user.id
      and e.inserted_at > ^start_of_today

    Repo.one(query)
  end
end
