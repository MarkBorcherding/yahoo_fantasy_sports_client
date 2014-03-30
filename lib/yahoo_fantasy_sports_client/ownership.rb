require 'happymapper'

module YahooFantasySportsClient
  class Ownership
    include HappyMapper
    element :ownership_type, String
  end
end
