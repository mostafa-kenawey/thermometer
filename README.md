# README

## Thermostat

API for storing readings from IoT thermostats and reporting a simple statistics on them.


## Available API Call:

  > POST `/api/thermostat_reads` stores temperature, humidity and battery charge, attributes thermostat_read[temperature], thermostat_read[humidity], thermostat_read[battery_charge], It requires HOUSEHOLD_TOKEN in the request header

  > GET `/api/thermostat_reads/:number` returns the thermostat data using the reading_id obtained from POST Reading, It requires HOUSEHOLD_TOKEN in the request header.

  > GET '/api/thermostats/:id/stats' returns the average, minimum and maximum by temperature, humidity and battery_charge


## Reads dummy data :

  > run `rails thermostat_reads:dummy_data`


## Project Details:

* Environment

  > API Rails Project

  > Ruby 2.6.1

  > Rails 5.2.2

  > PostgreSQL

  > RSpec

* Configuration

  > copy `config/database.yml` from `config/database.yml.example`

  > copy `config/sidekiq.yml` from `config/sidekiq.yml.example`

* Database creation

  > run `rails db:create`

  > run `rails db:migrate`

  > run `rails db:seed`

## Tests

  > database migration `rails db:migrate RAILS_ENV=test`

  > run test `rspec`

## Production Deploy and Recommendations:

  > copy `config/database.yml` from `config/database.yml.example`

  > copy `config/sidekiq.yml` from `config/sidekiq.yml.example`

## ToDo:

  > Add API documentation tool

  > Add Authentication to the API

  > Use API versioning

  > Include more test coverage

  > Add test code coverage tool : simplecov


## recommendations:

  > Create a new separated model for 'household'

  > Use `github.com/derrickreimer/sequenced` for Generate scoped sequential numbers
