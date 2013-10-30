require 'rss'

class NewsRelease < ActiveRecord::Base
  EOL_RSS_ADDR = "http://eir.eol.co.jp/EIR/Rss.aspx?code=3399&template=press:press1:yuho"
  
  named_scope :topics,{:conditions => "news_type = 0 and current_timestamp >= release_date",:order =>"release_date desc"}
  named_scope :ir,{:conditions => "news_type = 1 and current_timestamp >= release_date",:order =>"release_date desc"}
  named_scope :pure,{:conditions => "news_code is not null"}
  def self.read_from_eol
    @rss = nil
    begin
      @rss = RSS::Parser.parse(EOL_RSS_ADDR)
    rescue
      @rss = RSS::Parser.parse(EOL_RSS_ADDR,false)
    end
    @rss.items.each{ |i|
      nr = NewsRelease.find_by_tnu(i.title, i.link)
      if nr == nil
        nr = NewsRelease.new
        nr.title = i.title
        nr.news_type = 1
        nr.release_date = i.pubDate.to_s
        nr.url = i.link
        p nr
        nr.save
      end
    }
  end
  
  def self.find_by_tnu(title,url)
    return self.find(:first,:conditions => ["title = :title and url = :url",{:title => title,:url => url}])
  end
end
