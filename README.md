# Action for Children Mental Health App

## Why?

To improve children’s resilience in coping with change at a particularly
difficult transitionary time in their lives (10-13 years of age),
by using a tool that is already part of their daily lives (phones and mobile
apps).

## What?

Action for Children application allow users to record their emotions,
analyse the reasons for them, review their emotions
over a period of time and share them with their trusted adult.

The application is currently in prototype and user testing stages, with a
specific set of alpha users. Google Analytics, Redash and Hotjar are being used
to analyse the test data. At this stage a number of metrics are being tracked
with an aim to refine which are used in the future. See this
[issue](https://github.com/actnforchildren/mental_health_app/issues/14) for
more info on this.

Landing screen:

<img src="https://user-images.githubusercontent.com/15571853/49437222-e69ba700-f7b2-11e8-9121-d3a708ea7f50.png" width="250px" />

The daily, weekly and monthly views allow the user to see a record of their
previously logged emotions.

Daily view:

<img src="https://user-images.githubusercontent.com/15571853/49437940-bfde7000-f7b4-11e8-950b-1a1d582eae79.png" width="250px" />

Weekly view:

<img src="https://user-images.githubusercontent.com/15571853/49437360-45f9b700-f7b3-11e8-94de-265f6032d22c.png" width="250px" />

## How?

You will need to have [Docker](https://docs.docker.com/install/)
and [Docker Compose](https://docs.docker.com/compose/install/) installed to
run the application

### Run the application

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

### Deploy on Heroku

To create a new heroku app you can follow the Phoenix guide
https://hexdocs.pm/phoenix/heroku.html

Check that the heroku remote is defined `git remote -v`. For more information
you can read the heroku deployment guide:
https://devcenter.heroku.com/articles/git#creating-a-heroku-remote

To deploy a new branch you can run: `git push heroku your_branch:master`.

### Create users

As the application was being tested with a specific set of alpha users all the
users accounts were manually created. There is no way to create users in app.

To create a user, go to `priv/repo/create_users.exs`. Update the following line
```elixir
users = [
      {"USER1234", 1234},
      ]
```
with the username and pin you would like to use. These can be sourced from an
env variable if you want to keep them secret.

Once you have added your variables, in your terminal run the command
`mix run priv/repo/create_users.exs`. 
