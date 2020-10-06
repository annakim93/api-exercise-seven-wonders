require 'httparty'
require "awesome_print"
require 'dotenv'

Dotenv.load

US_BASE_URL = "https://us1.locationiq.com/v1/search.php"
# EU_BASE_URL = "https://eu1.locationiq.com/v1/search.php"
DIRECTIONS_URL = "https://us1.locationiq.com/v1/directions/driving/'31.243666,30.048819;31.1342193027636,29.9791509'"

unless ENV['LOCATION_IQ_API_KEY']
  puts "Could not load API key, please store in the environment variable 'LOCATION_IQ_API_KEY'"
  exit
end

LOCATION_IQ_KEY = ENV['LOCATION_IQ_API_KEY']


def get_location(search_term)
  response = HTTParty.get(US_BASE_URL, query: {
      key: LOCATION_IQ_KEY,
      q: search_term,
      format: 'json'
  })

  return { search_term => {
      lat: response[0]["lat"],
      lon: response[0]["lon"]
  } }
end

def find_seven_wonders

  seven_wonders = ["Great Pyramid of Giza", "Gardens of Babylon", "Colossus of Rhodes", "Pharos of Alexandria", "Statue of Zeus at Olympia", "Temple of Artemis", "Mausoleum at Halicarnassus"]

  seven_wonders_locations = []

  seven_wonders.each do |wonder|
    sleep(0.5)
    seven_wonders_locations << get_location(wonder)
  end

  return seven_wonders_locations
end

# def get_driving_directions(a, b)
#   # url = DIRECTIONS_URL + "{#{a.values[1]}},{#{a.values[0]}};{#{b.values[1]}},{#{b.values[0]}}"
#   # p url
#   response = HTTParty.get(DIRECTIONS_URL, query: {
#       key: LOCATION_IQ_KEY,
#       format: 'json'
#   })
#   ap response
# end

# Use awesome_print because it can format the output nicely
# ap find_seven_wonders
# Expecting something like:
# [{"Great Pyramid of Giza"=>{:lat=>"29.9791264", :lon=>"31.1342383751015"}}, {"Gardens of Babylon"=>{:lat=>"50.8241215", :lon=>"-0.1506162"}}, {"Colossus of Rhodes"=>{:lat=>"36.3397076", :lon=>"28.2003164"}}, {"Pharos of Alexandria"=>{:lat=>"30.94795585", :lon=>"29.5235626430011"}}, {"Statue of Zeus at Olympia"=>{:lat=>"37.6379088", :lon=>"21.6300063"}}, {"Temple of Artemis"=>{:lat=>"32.2818952", :lon=>"35.8908989553238"}}, {"Mausoleum at Halicarnassus"=>{:lat=>"37.03788265", :lon=>"27.4241455276707"}}]

sleep(0.5)
# p cairo = get_location("Cairo Egypt")
# p giza = get_location("Great Pyramid of Giza")

# p get_driving_directions(cairo, giza)

p DIRECTIONS_URL
# response = HTTParty.get(DIRECTIONS_URL, query: {
#     key: LOCATION_IQ_KEY,
#     format: 'json'
# })

# ap response