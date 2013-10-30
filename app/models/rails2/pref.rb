class Pref < ActiveRecord::Base
  has_many :shops,:foreign_key => "pref_code",:class_name=>"Shop",:order=>"id asc",:conditions=>"current_timestamp between date_add(inauguration, interval -45 day) and close"
  
  named_scope :shop_exists,lambda{
    {
      :select=>"prefs.*",
      :joins=>"inner join shops s on (prefs.id = s.pref_code)",
      :order=>"priority asc",
      :group=>"prefs.id"
    }
  }
end
