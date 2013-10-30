class TopController < ApplicationController

  anot :index , parent: '',title:'ラーメン山岡家'
  def index
    @news_s = NewsRelease.find(:all,:conditions => "news_type = 0",:limit => "7",:order => "release_date desc")
    @news_i = NewsRelease.find(:all,:conditions => "news_type = 1",:limit => "3",:order => "release_date desc")
  end

end
