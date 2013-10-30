class ShopController < ApplicationController
  layout "application", :except => [:search,:pref,:all_shops,:m,:kml,:new_shops]
  #caches_action :index,:shop

  def index

  end

  def shop
    @js = "gmapjs"
    @gmaps_code = GMAPS_CODE
      adt = AreaDetails.find_by_sql(
        "select d.*,a.code as area_code from area_details d inner join areas a on (d.area_id = a.id) inner join shops s on (d.shop_id =s.id) where (current_timestamp between s.inauguration and s.close) or (abs(datediff(current_timestamp,s.inauguration)) < 30) order by area_id,shop_id asc;"
      )

      @ad = Hash.new()
      @ad["all"] = Array.new();
      adt.each{|it|
        if(@ad[it.area_code] == nil) then
          @ad[it.area_code] = Array.new()
        end
        @ad[it.area_code] << it.shop_id
      }

    @areas = Area.find_by_sql("select * from areas order by soat_order;")
    @area_code = params["area_code"];

    begin
      #店舗一覧の取得
      @shops = Shop.find_current();
     @shops.each{|s|
       @ad["all"] << s.id
     }
     #対象店舗の取得
     @shop = Shop.find(params["id"])
    #所属地方の取得
    @area_belongs = AreaDetails.find_area_belongs(params["id"]).first.code
     #店舗採用情報の取得
     @rec_info = Recruit.find(
      :first,
      :conditions => ["current_timestamp between offer_from and offer_to and shop_id = ?",params["id"]]
    )
    rescue
    @err = true;
    p @err
    end

  end

  def m
     #対象店舗の取得
     @shop = Shop.find(params["id"])
  end

  def new_shops
    @search_sql = <<HERE
select * FROM  shops s
where current_timestamp between (date_add(inauguration,interval -30 day)) and close
order by s.inauguration DESC LIMIT 4;
HERE
    @shops = Shop.find_by_sql([@search_sql]);
    headers["Content-Type"] = "text/javascript"

  end

  def kml
        @search_sql = <<HERE
select * FROM shops s
where current_timestamp between inauguration and close
order by s.id asc;
HERE
    @shops = Shop.find_by_sql([@search_sql]);
    headers["Content-Type"] = "application/vnd.google-earth.kml+xml"
    respond_to{ |format| format.xml}
  end



  def list
   @js = "dummy"
   @shops = Shop.find_by_sql <<HERE
select
s.*,
p.name as pref_name,
p.area_code as area_code,
p.area_name as area_name,
(to_days(current_timestamp) - to_days(inauguration)) < 180 as is_new
from shops s
inner join prefs p on
(p.id = s.pref_code)
where current_timestamp between s.inauguration and s.close
order by p.area_code asc,p.priority asc,p.id asc,s.id asc;
HERE

  end


  def pref
    @search_sql = <<HERE
select s.id,s.name FROM area_details d
inner join areas a on (d.area_id =a.id)
inner join shops s on (d.shop_id =s.id)
where current_timestamp between (date_add(inauguration,interval -45 day)) and close
and a.code =? order by s.id desc;
HERE
    shopst = Shop.find_by_sql([@search_sql,params["code"]]);
    @shops = Array.new();
    shopst.each { |s|
      @shops << {:id=>s.id,:name=>s.name};
    }
  end

  def all_shops
    @search_sql = <<HERE
select s.id,s.name,lat,lng,pref_code FROM shops s
where current_timestamp between (date_add(inauguration,interval -45 day)) and close
order by s.id desc;
HERE
    shopst = Shop.find_by_sql([@search_sql]);
    @shops = Array.new();
    shopst.each { |s|
      @shops << {:id=>s.id,:name=>s.name,:lat=>s.lat,:lng=>s.lng,:pref_code => s.pref_code,:marker => nil};
    }
  end

  def search
    @search_sql = <<HERE
SELECT id FROM shops where
current_timestamp between inauguration and close
and sqrt(power((lat*111-?*111),2)+ power((lng*91-? *91),2)) < 30
order by
sqrt(power((lat*111-?*111),2)+ power((lng*91-? *91),2)) asc
HERE
    #geo = GoogleGeocode.new(GMAPS_CODE)
    @pos = Geocoder.coordinates(params["address"])

    #@pos = geo.locate(params["address"]).coordinates
    shopst = Shop.find_by_sql([@search_sql,@pos[0],@pos[1],@pos[0],@pos[1]])
    @shops = Array.new();
    shopst.each { |s|
      @shops << s.id
    }
    #redirect_to :action => "shop", :id => searchedId
  end
end
class OrderedHash < Hash
  def initialize
    @index = []
  end

  def []=(key, val)
    @index.delete(key)
    @index.push(key)
    super(key, val)
  end

  def each
    @index.each do |key|
      yield(key, self[key])
    end
    self
  end

end
