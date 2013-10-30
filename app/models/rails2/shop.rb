require 'static_map'
class Shop < ActiveRecord::Base
  belongs_to :pref

  def self.find_current
    return self.find(:all,
        :select => "id,name,phone,address",
        :conditions => "(current_timestamp between inauguration and close) or (abs(datediff(current_timestamp,inauguration)) < 30)",
        :order => "id asc")
  end

  def closed?
    return self.close < Date.today 
  end

  def short_id
    tmp_id = self.id - 120000
    sen = tmp_id.div(1000) * 100
    simo3 = tmp_id.modulo(1000)
    return simo3 + sen + 1000
  end

  def static_map
    return StaticMap::Image.new(
      {
        :size => '200x100',
        :sensor => false,
        :markers => [{
          :latitude => self.lat, 
          :longitude => self.lng,
          :color => "red",
          :label => "Y"}],
        :maptype => 'road',
        :zoom => self.zoom,
        :title => self.name,
        :alt =>  self.name
      }
    )
  end
end
