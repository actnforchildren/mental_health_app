alias Afc.{Repo, TrustedAdult, User}
trusted_adult_email = Map.fetch!(System.get_env(), "EMAIL_TRUSTED_ADULT")

adult =
  case Repo.get_by(TrustedAdult, email: trusted_adult_email) do
    nil ->
      Repo.insert!(%TrustedAdult{email: trusted_adult_email})
    adult ->
      adult
  end

users = [
      {"user1234", 1234},
      ]

Enum.each(
  users,
  fn({username, pin}) ->
    Repo.insert!(%User{
      username: username,
      pin: pin,
      trusted_adult_id: adult.id
    })
  end
)
