class TopController < ApplicationController
  layout "common"
  
  caches_action :index
  def index
    #NewsRelease.read_from_eol
    @news_s = NewsRelease.find(:all,:conditions => "news_type = 0",:limit => "7",:order => "release_date desc")
    @news_i = NewsRelease.find(:all,:conditions => "news_type = 1",:limit => "3",:order => "release_date desc")
  end

  def indexx
    #NewsRelease.read_from_eol
    @news_s = NewsRelease.find(:all,:conditions => "news_type = 0",:limit => "7",:order => "release_date desc")
    @news_i = NewsRelease.find(:all,:conditions => "news_type = 1",:limit => "3",:order => "release_date desc")
  end

  def index2
    #NewsRelease.read_from_eol
    @news_s = NewsRelease.find(:all,:conditions => "news_type = 0",:limit => "7",:order => "release_date desc")
    @news_i = NewsRelease.find(:all,:conditions => "news_type = 1",:limit => "3",:order => "release_date desc")
  end

end
