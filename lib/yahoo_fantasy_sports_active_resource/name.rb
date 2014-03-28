require 'happymapper'

class Name
  include HappyMapper
  element :full, String
  element :first, String
  element :last, String
end
