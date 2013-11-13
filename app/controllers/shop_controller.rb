class ShopController < ApplicationController

  def all_shops
  end

  def shops
    @shops = Shop.active
    @areas = Area.level1.active

    respond_to{ |format|
      format.kml{render kml: @shops }
      format.html
      format.json{render json: @shops.as_json(only:[:lat,:lng,:name,:id,:pref_code,:marker])}
    }
  end

  anot :shop , parent: 'shop#index',title:'店舗情報',pattern: 'shop/:id(.:format)',valiation: ->{
    Shop.active.map do |s|
      {
        controller: :shop,
        action: :shop,
        id: s.id,
        title: s.name,
        parent: 'shop#index',
        format: :html
      }
    end
  }
  def shop
    id = params[:id] if params[:id].present?
    @shop = Shop.find(id) if id
    area = @shop.areas.first if @shop.present?
    @area_code = area.code if area.present?
  end

  alias_method :index,:shop
  anot :index , parent: 'top#index',title:'店舗情報',pattern: 'shop(.:format)'


end
