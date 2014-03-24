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


#def get(url)
#  response = @access_token.get "http://fantasysports.yahooapis.com#{url}"
#  response.body
#rescue OAuth::Problem => e
#  puts e
#  FileUtils.rm '.access_token', force: true
#  FileUtils.rm '.access_secret', force: true
#end
#

#get "/fantasy/v2/users;use_login=1/games;game_keys=mlb"
#
#get "/fantasy/v2/game/328"
#
#get "/fantasy/v2/users;use_login=1/games;game_keys=328/leagues"
#
#puts get "/fantasy/v2/league/328.l.46539/players"
#

class Resource
  def self.access_token=(value)
    @@access_token = value
  end

  def self.access_token
    @@access_token
  end

  def self.get(url)
    response = access_token.get "http://fantasysports.yahooapis.com#{url}"
    response.body
  rescue OAuth::Problem => e
    puts e
    FileUtils.rm '.access_token', force: true
    FileUtils.rm '.access_secret', force: true
    exit
  rescue
    puts 'who knows'
    exit
  end
end
Resource.access_token = @access_token

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

class League
  include HappyMapper
  element :league_key, String
  element :league_id, Integer
  element :name, String
  element :url, String
  element :draft_status, String
  element :num_teams, Integer
  element :edit_key, Integer
  element :league_update_timestamp, String
  element :scoreing_type, String
  element :current_week, Integer
  element :start_week, Integer
  element :end_week, Integer
  element :is_finished, Integer

   # <weekly_deadline/>
end

class Name
  include HappyMapper
  element :full, String
  element :first, String
  element :last, String
end

class Ownership
  include HappyMapper
  element :ownership_type, String
end

class Player < Resource
  include HappyMapper
  element :player_key, String
  element :player_id, Integer
  has_one :name, Name
  element :postition_type, String
  has_one :ownership, Ownership
  def self.get_page(page, page_size=25)
    xml = get "/fantasy/v2/league/328.l.46539/players/ownership;count=#{page_size};start=#{page * page_size}"
    puts xml
    Player.parse xml
  end
end

page=0
print 'Players'
pp = Player.get_page(page)
debugger

File.open "players.txt", "w" do |f|
  while (pp = Player.get_page(page)).count > 0 do
    print '.'
    page += 1

    pp.each do |p|
      f.write p.name.full
      f.write " , "
      f.write p.ownership.ownership_type
      f.write "\n"
    end
  end
end


debugger



true
