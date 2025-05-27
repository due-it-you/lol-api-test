require 'net/http'
require 'uri'
require 'json'
require 'dotenv'
require 'cgi'
Dotenv.load

game_name = CGI.escape('たかスペ')
tag_line = CGI.escape('JP2')
endpoint = 'https://asia.api.riotgames.com'
path = "/riot/account/v1/accounts/by-riot-id/#{game_name}/#{tag_line}"
api_key = ENV['API_KEY']

uri = URI.parse("#{endpoint}#{path}?api_key=#{ENV['API_KEY']}")
return_data = Net::HTTP.get(uri)

data = JSON.parse(return_data)

puts data['puuid']