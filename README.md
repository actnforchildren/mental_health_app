The Action for Children application allow users to record their emotions.
![image](https://user-images.githubusercontent.com/6057298/48003870-9a077200-e107-11e8-92d0-9095e95b615f.png)

The daily, weekly and monthly views allow the user to see a record of their previously logged emotions.

![image](https://user-images.githubusercontent.com/6057298/48004048-100bd900-e108-11e8-86a5-611b240fcde7.png)


# Setup

You will need to have [Docker](https://docs.docker.com/install/)
and [Docker Compose](https://docs.docker.com/compose/install/) installed to run the application

## Run the application

- clone this repository and go to the new directory
      `git clone git@github.com:actnforchildren/mental_health_app.git`
     then `cd mental_health_app`

- create a .env file to define the environment variables:
```
MAILGUN_API_KEY=...
MAILGUN_DOMAIN=...
EMAIL_FROM=...
EMAIL_TRUSTED_ADULT=...
```

- update the phoenix dependencies:
  `docker-compose run --rm app mix deps.get`

- install the nodejs packages with npm
  `docker-compose run --rm app npm --prefix ./assets install`

- create the database
  `docker-compose run --rm app mix ecto.create`

- run the migrations:
  `docker-compose run --rm app mix ecto.migrate`

- create/add users:
  `docker-compose run --rm app mix run priv/repo/create_test_users.exs`

- run the application with
  `docker-compose up`

- visit the app on localhost:4000

## Deploy on Heroku


To create a new heroku app you can follow the Phoenix guide https://hexdocs.pm/phoenix/heroku.html

Check that the heroku remote is defined `git remote -v`. For more information you can read the heroku deployment guide: https://devcenter.heroku.com/articles/git#creating-a-heroku-remote

To deploy a new branch you can run: `git push heroku your_branch:master`.
