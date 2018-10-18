defmodule Afc.Emotion do
  alias Afc.Repo
  alias Afc.Emotion.{Angry, EmotionLog, Happy}
  import Ecto.Query
  use Timex

  def todays_emotion_log(user) do
    start_of_today = Timex.today() |> Timex.to_naive_datetime()

    query =
      from e in EmotionLog,
      where: e.user_id == ^user.id
      and e.inserted_at > ^start_of_today

    Repo.one(query)
  end

  def get_emotion_module_name(emotion) do
    emotion_str =
      case is_atom(emotion) do
        true ->
          Atom.to_string(emotion)
        false ->
          emotion
      end
      |> String.capitalize()

    "Elixir.Afc.Emotion." <> emotion_str
    |> String.to_atom()
  end

  def get_emotion_map(emotion_str) do
    emotion_atom = String.to_atom(emotion_str)
    emotions_map() |> Map.get(emotion_atom)
  end

  def emotion_list do
    emotions_map()
    |> Map.keys()
  end

  defp emotions_map do
    %{
      happy: Map.new([module: Happy, emoji: "😆"]),
      angry: Map.new([module: Angry, emoji: "😡"]),
      excited: Map.new([module: Angry, emoji: "🤩"]),
      sad: Map.new([module: Angry, emoji: "😭"]),
      worried: Map.new([module: Angry, emoji: "😬"]),
      dont_know: Map.new([module: Angry, emoji: "😐"]),
      else: Map.new([module: Angry, emoji: "😶"])
    }
  end
end
