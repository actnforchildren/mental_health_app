alias Afc.{Repo, TrustedAdult, User}
trusted_adult_email = Map.fetch!(System.get_env(), "EMAIL_TRUSTED_ADULT")

adult =
  case Repo.get_by(TrustedAdult, email: trusted_adult_email) do
    nil ->
      Repo.insert!(%TrustedAdult{email: trusted_adult_email})
    adult ->
      adult
  end

Enum.each(
  1..9,
  fn(n) ->
    pin = String.to_integer("#{n}#{n}#{n}#{n}")

    Repo.insert!(%User{
      username: "test#{n}",
      pin: pin,
      trusted_adult_id: adult.id
    })
  end
)
