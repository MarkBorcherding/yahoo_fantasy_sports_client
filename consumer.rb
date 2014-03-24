require 'debugger'
require 'oauth'
require 'highline/import'
require 'dotenv'
require 'awesome_print'
Dotenv.load
require 'fileutils'

options = {
  :site                 => 'https://api.login.yahoo.com',
  :scheme               => :query_string,
  :http_method          => :get,
  :request_token_path   => '/oauth/v2/get_request_token',
  :access_token_path    => '/oauth/v2/get_token',
  :authorize_path       => '/oauth/v2/request_auth'
}

@consumer=OAuth::Consumer.new(
  ENV['consumer_key'],
  ENV['consumer_secret'],
  options)

def get_access_token
  request_token = @consumer.get_request_token
  puts "Visit #{request_token.authorize_url}"
  access_token_text = ask('Enter the token:')
  @access_token = request_token.get_access_token :oauth_verifier => access_token_text
  FileUtils.rm '.access_token', force: true
  File.open('.access_token','w') { |f| f.write(@access_token.token) }
  FileUtils.rm '.access_secret', force: true
  File.open('.access_secret','w') { |f| f.write(@access_token.secret) }
end

access_token_text = IO.read('.access_token') if File.exist? '.access_token'
access_secret_text = IO.read('.access_secret') if File.exist? '.access_secret'
unless access_token_text && access_secret_text
  get_access_token
else
  @access_token = OAuth::AccessToken.new(@consumer, access_token_text, access_secret_text)
end


require 'nokogiri'
def get(url)
  response = @access_token.get "http://fantasysports.yahooapis.com#{url}"
  response.body
rescue OAuth::Problem => e
  puts e
  FileUtils.rm '.access_token', force: true
  FileUtils.rm '.access_secret', force: true
end


get "/fantasy/v2/users;use_login=1/games;game_keys=mlb"

get "/fantasy/v2/game/328"

get "/fantasy/v2/users;use_login=1/games;game_keys=328/leagues"

puts get "/fantasy/v2/league/328.l.46539/players"


require 'happymapper'
class Game
  include HappyMapper
  element :game_key, Integer
  element :game_id, Integer
  element :name, String
  element :code, String
  element :type, String
  element :url, String
  element :season, String
end

class Name
  include HappyMapper
  element :full, String
  element :first, String
  element :last, String
end

class Player
  include HappyMapper
  element :player_key, String
  element :player_id, Integer
  element  :name, Name
  element :postition_type, String
#    <editorial_player_key>mlb.p.6419</editorial_player_key>
#    <editorial_team_key>mlb.t.22</editorial_team_key>
#    <editorial_team_full_name>Philadelphia Phillies</editorial_team_full_name>
#    <editorial_team_abbr>Phi</editorial_team_abbr>
#    <uniform_number>11</uniform_number>
#    <display_position>SS</display_position>
#    <headshot>
#     <url>http://l.yimg.com/iu/api/res/1.2/5AqpT7bBaHmFvXGz4LczCQ--/YXBwaWQ9eXZpZGVvO2NoPTg2MDtjcj0xO2N3PTY1OTtkeD0xO2R5PTE7Zmk9dWxjcm9wO2g9NjA7cT0xMDA7dz00Ng--/http://l.yimg.com/j/assets/i/us/sp/v/mlb/players_l/20130405/6419.1.jpg</url>
#     <size>small</size>
#    </headshot>
#    <image_url>http://l.yimg.com/iu/api/res/1.2/5AqpT7bBaHmFvXGz4LczCQ--/YXBwaWQ9eXZpZGVvO2NoPTg2MDtjcj0xO2N3PTY1OTtkeD0xO2R5PTE7Zmk9dWxjcm9wO2g9NjA7cT0xMDA7dz00Ng--/http://l.yimg.com/j/assets/i/us/sp/v/mlb/players_l/20130405/6419.1.jpg</image_url>
#    <is_undroppable>0</is_undroppable>
#    <position_type>B</position_type>
#    <eligible_positions>
#     <position>SS</position>
#     <position>Util</position>
#    </eligible_positions>
#    <has_player_notes>1</has_player_notes>
#    <has_recent_player_notes>1</has_recent_player_notes>
#   </player>
end

xml = get "/fantasy/v2/league/328.l.46539/players"
g = Player.parse xml
puts g.inspect


