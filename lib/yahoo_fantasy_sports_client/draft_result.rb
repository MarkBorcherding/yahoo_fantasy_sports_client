require 'happymapper'

module YahooFantasySportsClient
  class DraftResult < Resource
    include HappyMapper
    element :pick, Integer
    element :round, Integer
    element :team, String
    element :player, String
  end
end
