require 'happymapper'

require_relative 'draft_results'

module YahooFantasySportsClient
  class League < Resource
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
    has_one :draft_results, DraftResults

    # <weekly_deadline/>
    #
    def self.draft_results
      xml = get "/fantasy/v2/league/328.l.46539/draftresults"
      puts xml
      debugger
      League.parse(xml, single: true ).draft_results
    end

  end
end
