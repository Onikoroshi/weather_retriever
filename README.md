# Weather Retrieval app built with Ruby on Rails

## Scope
1. Use Ruby on Rails.
2. Accept an address as input. Give the user a selection of valid addresses as they type.
3. Retrieve weather data for that address. This should include, at minimum, the current temperature. Bonus points: retrieve high/low and/or extended forecast. This latter goal requires payment, so is not implemented. However, I did retrieve more information than just the current temperature.
4. Display the weather details to the user.
5. Cache weather details for 30 minutes for all subsequent requests to the same zip code. Display indicator if the result is pulled from the cache.

## Set Up Rails
This is developed on a MacBook Pro Intel running MacOS Monterey

### use RVM for ruby and gemsets
```sh
rvm install 3.2.2
```

### install Rails 7
```sh
install gem rails
```

### Engage Cron if you want the cleanup job to run
#### apply the schedule to the cron table with the correct environment set
```sh
whenever --update-crontab --set environment='development'
```

#### see the active jobs
```sh
crontab -l
```

#### delete all the jobs when you're done
```sh
crontab -r
```

#### output automatically sent in system mail
```sh
mail
```
- This lets you see the mail waiting.
- Use the appropriate number to see the message, and you should see the output of the job saying how many objects are being removed.
- Use the `delete 1-n` command to delete the appropriate emails.

## Engage with third party APIs

### Store API Keys in the Rails Credentials secrets
```sh
EDITOR="atom --wait" rails credentials:edit --environment=development
```
Add the API keys there.
give the master key (stored in `config/credentials/development.key` to authorized users for local testing.

### Connect with the Open Weather API using a gem
Use the [Open Weather Ruby Client Gem](https://github.com/dblock/open-weather-ruby-client)

### Connect with the [Google Maps API Place Autocomplete Address Form](https://developers.google.com/maps/documentation/javascript/examples/places-autocomplete-addressform#maps_places_autocomplete_addressform-javascript) and use it in the Stimulus javascript controller.

## Store Weather Data

1. Pass the information gained from the Google Maps API: latitude, longitude, postal code, and country code to the controller.
2. Use the postal code and country code to find any weather information that already exists in the database and is less than 30 minutes old.
3. If there is no recent data, reach out to the Open Weather API, get a report for that lat/long, and store that in the database.
4. Cron Job runs every day to catch any stale data hanging around.

I was tempted to use simple calls to `Rails.cache`, but eventually decided that cutting out half of the functionality of a Rails application (creating and interacting with databases) was not a good idea. This strategy is intended not for ease of implementation, but to showcase a more comprehensive use of the Rails ecosystem.
