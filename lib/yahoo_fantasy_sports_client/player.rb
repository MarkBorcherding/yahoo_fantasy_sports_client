require 'happymapper'
require_relative 'resource'
require_relative 'name'
require_relative 'ownership'

module YahooFantasySportsClient
  class Player < Resource
    include HappyMapper
    element :player_key, String
    element :player_id, Integer
    has_one :name, Name
    element :postition_type, String
    has_one :ownership, Ownership

    def self.resource_url
      "league/328.l.46539/players/ownership;count=#{page_size};start=#{page * page_size}"
    end

    def self.get_page(page, page_size=25)
      xml = get "/fantasy/v2/league/328.l.46539/players/ownership;count=#{page_size};start=#{page * page_size}"
      parse xml
    end

  end
end
