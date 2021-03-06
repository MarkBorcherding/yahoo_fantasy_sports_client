require 'debugger'
require 'oauth'
require 'highline/import'
require 'dotenv'
require 'awesome_print'
Dotenv.load
require 'fileutils'

require 'yahoo_fantasy_sports_client'

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




def get(url)
  response = @access_token.get "http://fantasysports.yahooapis.com#{url}"
  response.body
rescue OAuth::Problem => e
  puts e
  FileUtils.rm '.access_token', force: true
  FileUtils.rm '.access_secret', force: true
end


YahooFantasySportsClient::Game.access_token = @access_token
games = YahooFantasySportsClient::Game.all_for_user
debugger

#
#get "/fantasy/v2/game/328"
#
#get "/fantasy/v2/users;use_login=1/games;game_keys=328/leagues"
#
#puts get "/fantasy/v2/league/328.l.46539/players"
#

YahooFantasySportsClient::Resource.access_token = @access_token


dr = YahooFantasySportsClient::League.draft_results

debugger
true
