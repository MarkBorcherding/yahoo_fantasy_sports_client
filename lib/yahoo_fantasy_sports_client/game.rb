require 'happymapper'

module YahooFantasySportsClient
  class Game
    include HappyMapper
    include Resource
    element :game_key, Integer
    element :game_id, Integer
    element :name, String
    element :code, String
    element :type, String
    element :url, String
    element :season, String

    def self.all_for_user
      all "users;use_login=1/games"
    end
  end
end
