alias Afc.{Repo, TrustedAdult, User}
alias Afc.Emotion.{Angry, Else, EmotionLog, Excited, Happy, Sad, Unsure, Worried}

dummy_user = System.get_env("DUMMY_USER") |> String.downcase()
trusted_adult_email = Map.fetch!(System.get_env(), "EMAIL_TRUSTED_ADULT")

emotions = [
  {Angry, "angry"},
  {Else, "else"},
  {Excited, "excited"},
  {Happy, "happy"},
  {Sad, "sad"},
  {Unsure, "unsure"},
  {Worried, "worried"}
]

trusted_adult_email = trusted_adult_email
adult =
  case Repo.get_by(TrustedAdult, email: trusted_adult_email) do
    nil ->
      Repo.insert!(%TrustedAdult{email: trusted_adult_email})
    adult ->
      adult
  end

case Repo.get_by(User, username: dummy_user) do
  nil ->
    user = Repo.insert!(%User{username: dummy_user, pin: 1234, trusted_adult_id: adult.id})

    today = Timex.today() |> Timex.to_naive_datetime()
    rest_of_week = Enum.map(1..6, &Timex.shift(today, days: -&1))

      Enum.map(rest_of_week, fn(day) ->
        {emotion_module, emotion_str} = Enum.random(emotions)
        module_struct = struct(emotion_module)
        changeset = emotion_module.changeset(module_struct, %{reason: "test reason"})
        emotion = Repo.insert!(changeset)
        Repo.insert!(%EmotionLog{
          emotion: emotion_str,
          emotion_id: emotion.id,
          inserted_at: day, updated_at: day,
          user_id: user.id
        })
      end)
  user ->
    user
end
