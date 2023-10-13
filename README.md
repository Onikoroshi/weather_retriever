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

## Engage with third party APIs

### Connect with the Open Weather API using a gem
Use the [Open Weather Ruby Client Gem](https://github.com/dblock/open-weather-ruby-client)
