class NewsController < ApplicationController
  before_filter :force_plain
  anot :index , parent: 'top#index',title:'ニュース'
  def index
  end
end
