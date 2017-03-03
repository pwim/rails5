# Rails5 on Convox Example

This repository contains an example Ruby on Rails 5 app configured for local development and deployment to Convox. The `.dockerignore`, `docker-compose.yml`, and `Dockerfile` in this example were generated by the `convox init` command.

## Development

Create a `.env` file with the following contents:

```
BUNDLE_WITHOUT=none
RACK_ENV=development
RAILS_ENV=development
```

Run:

```
$ convox start
```

## Deployment

Create a Convox app:

```
$ convox apps create rails5
```

Set a new `SECRET_KEY_BASE`:

```
$ convox env set SECRET_KEY_BASE=<my long random hex string>
```

Deploy the app:

```
$ convox deploy
```

## Get a Real Database

We recommend you replace the containerized database with a hosted database for your deployed app.

First create the database:

```
$ convox resources create postgres --name=rails5-db
Creating rails5-db (postgres: name="rails5-db")... CREATING
```

This will take about 10 minutes. Once `convox resources` shows its status as "running" grab its URL:

```
$ convox resources info rails5-db
Name    rails5-db
Status  running
Exports
  URL: postgres://postgres:53df9498e94410d8348db0724ce6dc@dev-rails5-db.cbm068zjzjcr.us-east-1.rds.amazonaws.com:5432/app
```

Set the value of `DATABASE_URL`:

```
$ convox env set DATABASE_URL=postgres://postgres:53df9498e94410d8348db0724ce6dc@dev-rails5-db.cbm068zjzjcr.us-east-1.rds.amazonaws.com:5432/app --promote
```

And scale down the database container:

```
$ convox scale database --count=-1
```
