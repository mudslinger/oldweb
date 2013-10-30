class Recruit < ActiveRecord::Base
  named_scope :active,
    lambda{
      {
        :conditions => "current_timestamp between offer_from and offer_to",
        :joins => "inner join shops on (shops.id = shop_id)",
        :select => "*,shops.name as shop_name,shops.address as shop_address,shops.phone as shop_phone"
      }
    }

    
end
