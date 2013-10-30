class AreaDetails < ActiveRecord::Base

    def self.find_area_belongs(shop_id)
      return self.find(
        :all,
        :conditions => ["shop_id = ?",shop_id],
        :joins => "inner join areas a on (a.id = area_details.area_id)",
        :order => "a.level desc",
        :select => "a.code as code"
      )
    end
end
