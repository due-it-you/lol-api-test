require 'net/http'
require 'uri'
require 'json'
require 'dotenv'
require 'cgi'
Dotenv.load

# puuidの取得
game_name = CGI.escape('ヒイロ')
tag_line = CGI.escape('JP1')
endpoint = 'https://asia.api.riotgames.com'
path = "/riot/account/v1/accounts/by-riot-id/#{game_name}/#{tag_line}"
api_key = ENV['API_KEY']

uri = URI.parse("#{endpoint}#{path}?api_key=#{ENV['API_KEY']}")
return_data = Net::HTTP.get(uri)

data = JSON.parse(return_data)

# match idsの取得
match_ids_path = "/lol/match/v5/matches/by-puuid/#{data['puuid']}/ids"
uri = URI.parse("#{endpoint}#{match_ids_path}?api_key=#{ENV['API_KEY']}")
return_data = Net::HTTP.get(uri)

match_ids = JSON.parse(return_data)

match_path = "/lol/match/v5/matches/#{match_ids.last}"

uri = URI.parse("#{endpoint}#{match_path}?api_key=#{ENV['API_KEY']}")

return_data = Net::HTTP.get(uri)

match_data = JSON.parse(return_data)

p match_data["metadata"]["participants"]