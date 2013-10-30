class Genre < ActiveRecord::Base
  has_many :menus,:class_name=>"Menu",:order=>"id asc",:conditions=>"current_timestamp between sell_from and sell_to"
  named_scope :for_questionnaire ,:conditions=>"for_questionnaire = 0"
  
end
