class PropertyController < ApplicationController
  before_filter :force_plain
  anot :index , parent: 'top#index',title:'物件募集'
  def index
  end

end
