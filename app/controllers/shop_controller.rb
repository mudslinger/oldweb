class ShopController < ApplicationController


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
    #javascript用データ
    #@areamap = areas
  end

  alias_method :index,:shop
  anot :index , parent: 'top#index',title:'店舗情報',pattern: 'shop(.:format)'


end
