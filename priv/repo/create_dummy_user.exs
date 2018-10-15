alias Afc.{Repo, TrustedAdult, User}

adult = Repo.insert!(%TrustedAdult{email: "trusted@adult.com"})

Repo.insert!(%User{
  username: "test_user",
  pin: 1234,
  trusted_adult_id: adult.id
})
