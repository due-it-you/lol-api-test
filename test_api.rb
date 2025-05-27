require 'net/http'
require 'uri'
require 'json'
require 'dotenv'
Dotenv.load

endpoint = 'https://jp1.api.riotgames.com'
path = '/lol/platform/v3/champion-rotations'
api_key = ENV['API_KEY']

uri = URI.parse("#{endpoint}#{path}?api_key=#{ENV['API_KEY']}")
return_data = Net::HTTP.get(uri)

puts return_data