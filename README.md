# Setup

You will need to have [Docker](https://docs.docker.com/install/)
and [Docker Compose](https://docs.docker.com/compose/install/) installed to run the application

## Run the application

- clone this repository and go to the new directory
      `git clone git@github.com:actnforchildren/mental_health_app.git`
     then `cd mental_health_app`

- update the phoenix dependencies:
  `docker-compose run --rm app mix deps.get`

- install the nodejs packages with npm
  `docker-compose run --rm app npm --prefix ./assets install`

- create the database
  `docker-compose run --rm app mix ecto.create`
- run the application with
  `docker-compose up`

- visit the app on localhost:4000

## Create a new Phoenix application with Docker

You don't need to do this section as the application is now generated.

- Create a new Phoenix project:
  ```docker-compose run --rm app mix phx.new . --app afc```

  answer yes to `The directory /app already exists. Are you sure you want to continue? [Yn]` and `Fetch and install dependencies? [Yn]`

- On linux you will need to change the owner of the application (docker create the phoenix app with the root user)
 run `sudo chown -R $USER:$USER app/`

- update the database configuration. Change the host to be the name of the service (ie db) in app/config/dev.exs
