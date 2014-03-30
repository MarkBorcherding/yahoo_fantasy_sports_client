require 'happymapper'

module YahooFantasySportsClient
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
end
