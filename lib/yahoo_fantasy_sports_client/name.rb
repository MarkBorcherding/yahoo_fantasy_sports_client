require 'happymapper'

module YahooFantasySportsClient
  class Name
    include HappyMapper
    element :full, String
    element :first, String
    element :last, String
  end
end
