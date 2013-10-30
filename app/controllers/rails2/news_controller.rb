class NewsController < ApplicationController
  
    
  #正しく動作するか検証
  caches_action :all
  
  def index
    @topics = NewsRelease.topics
    @ir = NewsRelease.ir
  end
  
  def update_news_release
    begin
      NewsRelease.read_from_eol
      render :nothing =>true,:status => 200
    rescue
      render :nothing =>true,:status => 500
    end
  end
end
