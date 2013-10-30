# -*- coding: utf-8 -*-
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include SslRequirement

  helper :all
  before_filter :metadata_load
  
  layout "common"
  GMAPS_CODE = ENV["GMAPS_CODE"]
  
  def metadata_load
    @ca = request.path_parameters()
    @ctrl = @ca["controller"]
    @act = @ca["action"]
    
    @metadata = Site.find_current(:ctrl =>@ctrl, :act => @act,:item_id => params["id"], :menu_page => params["page"])
    @links = Array.new
    lo = @metadata
    while lo 
      @links.push lo
      lo = lo.parent
    end
    @links.reverse!
    #@metadata = YAML.load_file(RAILS_ROOT + "/app/controllers/metadata.yml")[@ctrl][@act]
  end
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery  :secret => '9a98c2b8cef9a4e9354c42e73cd88aa2'
  #init_gettext "hp"

  def rescue_404
    p "err"
    rescue_action_in_public CustomNotFoundError.new
  end

  def rescue_action_in_public(exception)
    p exception
    @metadata = Site.create(
        :name=>"ページが見つかりません",
        :description=>"あなたのアクセスしようとしたページが見つかりませんでした",
        :controller=>"application",
        :action=>"about",
        :priority=>0.2,
        :last_modified=>Time.now,
        :change_freq => "yearly"
      )

    case exception
      when CustomNotFoundError, ::ActionController::UnknownAction then
        #render_with_layout "shared/error404", 404, "standard"
        p exception
        render :template => "site/404", :layout=>"common",:status => "404"
      else
        @message = exception
        p exception
        render :template => "site/404", :status => "500"
    end
  end

  def local_request?
    return false
  end

  class CustomNotFoundError

  end
end

