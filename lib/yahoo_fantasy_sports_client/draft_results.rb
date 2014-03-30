require 'happymapper'
require_relative 'draft_result'

module YahooFantasySportsClient
  class DraftResults < Resource
    include HappyMapper
    has_many :draft_result, DraftResult
  end
end
