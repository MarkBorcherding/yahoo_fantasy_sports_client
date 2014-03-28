require 'oauth'
require 'fileutils'

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
