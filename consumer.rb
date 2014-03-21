require 'debugger'
require 'oauth'
require 'highline/import'
require 'dotenv'
require 'awesome_print'
Dotenv.load

options = {
  :site                 => 'https://api.login.yahoo.com',
  :scheme               => :query_string,
  :http_method          => :get,
  :request_token_path   => '/oauth/v2/get_request_token',
  :access_token_path    => '/oauth/v2/get_token',
  :authorize_path       => '/oauth/v2/request_auth'
}

consumer=OAuth::Consumer.new(
  ENV['consumer_key'],
  ENV['consumer_secret'],
  options)

access_token_text = ask('Enter current token: ')
access_secret_text = ask('Enter current secret: ')
if access_token_text == '' || access_secret_text == ''
  request_token = consumer.get_request_token
  puts "Visit #{request_token.authorize_url}"
  access_token_text = ask('Enter the token:')
  access_token = request_token.get_access_token :oauth_verifier => access_token_text
else
  access_token = OAuth::AccessToken.new(consumer, access_token_text, access_secret_text)
end


response = access_token.get "http://fantasysports.yahooapis.com/fantasy/v2/game/nfl"
ap response.body


