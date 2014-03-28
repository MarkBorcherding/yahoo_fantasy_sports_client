require 'happymapper'
require_relative 'draft_result'

class DraftResults < Resource
  include HappyMapper
  has_many :draft_result, DraftResult
end
