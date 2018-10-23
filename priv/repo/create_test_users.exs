alias Afc.{Repo, TrustedAdult, User}

adult =
  case Repo.get_by(TrustedAdult, email: "trusted@adult.com") do
    nil ->
      Repo.insert!(%TrustedAdult{email: "trusted@adult.com"})
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
