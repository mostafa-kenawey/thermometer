# README

## Thermostat

API for storing readings from IoT thermostats and reporting a simple statistics on them.


## Available API Call:


## Project Details:

* Environment

  > API Rails Project

  > Ruby 2.6.1

  > Rails 5.2.2

  > PostgreSQL

  > RSpec

* Configuration

  > copy `config/database.yml` from `config/database.yml.example`

* Database creation

  > run `rails db:create`

  > run `rails db:migrate`

  > run `rails db:seed`

## Tests

  > database migration `rails db:migrate RAILS_ENV=test`

  > run test `rspec`

## Production Deploy and Recommendations:

  > copy `config/database.yml` from `config/database.yml.example`

## ToDo:

  > Add API documentation tool

  > Add Authentication to the API

  > Include more test coverage


## recommendations:

  > Create a new separated model for 'household'

  > Use `github.com/derrickreimer/sequenced` for Generate scoped sequential numbers
