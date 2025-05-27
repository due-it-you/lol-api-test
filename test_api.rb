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

# 特定のプレイヤーが同試合にいる確率の計算処理
total_match_count = match_ids.size
sniper_involved_match_count = 0
sniper_uuid = 'WDbv5uMorZbemgyXCROYf2aJaH_WDsMuzzXSDoZAAVc_YMroQj_sTFVtn95CL60la52J2jLX6yXXnA'

match_ids.each do |match_id|
  match_path = "/lol/match/v5/matches/#{match_id}"
  uri = URI.parse("#{endpoint}#{match_path}?api_key=#{ENV['API_KEY']}")
  return_data = Net::HTTP.get(uri)
  match_data = JSON.parse(return_data)
  participants = match_data["metadata"]["participants"]
  sniper_involved_match_count += 1 if participants.include?(sniper_uuid)
end

sniper_involved_match_rate_int = sniper_involved_match_count.to_f / total_match_count * 100
sniper_involved_match_rate = sniper_involved_match_rate_int.to_s + "%"

puts sniper_involved_match_rate 
