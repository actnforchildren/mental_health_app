defmodule Afc.Emotion do
  alias Afc.Repo
  alias Afc.Emotion.{
    Angry, Else, EmotionLog, Excited, Happy, Sad, Unsure, Worried
  }
  import Ecto.Query
  use Timex

  @moduledoc false

  def get_emotion_log_for_date(user, date) do
    start_date = date |> Timex.to_naive_datetime()
    end_date = Timex.shift(start_date, days: 1)
    query =
      from e in EmotionLog,
      where: e.user_id == ^user.id
      and e.inserted_at >= ^start_date
      and e.inserted_at < ^end_date

    List.last(Repo.all(query))
  end

# e.g [[:happy, 2], [:excited, 1]]
  def get_emotion_report(user, from, to) do
    from_date = Timex.to_naive_datetime(from)
    to_date = Timex.to_naive_datetime(to)
    query =
      from e in EmotionLog,
      select: [e.emotion, count(e.id)],
      where: e.user_id == ^user.id
      and e.inserted_at >= ^from_date
      and e.inserted_at <= ^to_date,
      group_by: e.emotion,
      order_by: [desc: count(e.id)]

    Repo.all(query)
  end

  def get_emotion_module_name(emotion) do
    emotion_str =
      emotion
      |> is_atom()
      |> case do
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

  def reason_list do
    [
      :friends, :school, :"family/home", :community, :bullying, :exams,
      :teachers, :classwork, :homework, :else
    ]
  end

  defp emotions_map do
    %{
      happy: Map.new([module: Happy, emoji: "😆"]),
      angry: Map.new([module: Angry, emoji: "😡"]),
      excited: Map.new([module: Excited, emoji: "🤩"]),
      sad: Map.new([module: Sad, emoji: "😭"]),
      worried: Map.new([module: Worried, emoji: "😬"]),
      unsure: Map.new([module: Unsure, emoji: "🤔"]),
      else: Map.new([module: Else, emoji: "😶"])
    }
  end
end
