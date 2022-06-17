# fantasy-api

Fetches and stores data from the CBS API for baseball, basketball, and football, and returns a JSON API to search players based on any combination of the following parameters:

    * Sport
    * First letter of last name
    * A specific age (ex. 25)
    * A range of ages (ex. 25 - 30)
    * The player’s position (ex: “QB”)

## Running Locally

`cd fantasy-api`

`bundle install`

`rails db:migrate`

`rake initial_import`

`rails server`

## Endpoints

`/players/:id`

`/search`
     params: `sport`, `position`, `min_age`, `max_age`, `first_letter_of_last_name`
