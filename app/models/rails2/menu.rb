class Menu < ActiveRecord::Base
  belongs_to :genre
  
  named_scope :top_push,lambda{
    {
      :conditions => "push_priority is not null and (current_timestamp between sell_from and sell_to or current_timestamp between promotion_from and promotion_to)",
      :order => "push_priority asc"
    }
  }

  def new?
    @mb =  30.days.ago Time.new
    @ma = 30.days.since Time.new 
    return (@mb < sell_from and @ma > sell_from)
  end
  
  def self.find_current(page)
  return self.find(
        :all,
        :select => "menus.*,case when (current_timestamp between sell_from and sell_to or current_timestamp between promotion_from and promotion_to) then genres.page else 100 end as page,genres.name as genre_name,case when current_timestamp < sell_from then 0 else 1 end as now_on_sale",
        :conditions => "current_timestamp between inauguration and close",
        :joins => :genre,
        :conditions => ["case when (current_timestamp between sell_from and sell_to or current_timestamp between promotion_from and promotion_to) then genres.page else 100 end = ? and genres.id = genre_id",page],
        :order => "genres.soat asc,id asc"
    )
  end

end
