class PropertyController < ApplicationController
  caches_action :index
  def index
    @shop_count = Shop.count_by_sql("select count(id) from shops where current_timestamp between inauguration and close")
  end
end
