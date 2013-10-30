class SiteController < ApplicationController

  layout "common",:except=>[:sitemap_xml]
  caches_action :about,:sitemap,:sitemap_xml
  def about
    
  end
  
  def sitemap
    @site = Site.root.first
    @tree = Builder::XmlMarkup.new :indent => 2
    smr(@tree,@site)
    
  end
  
  def inquiry
    
  end
  
  def sitemap_xml
    @sites = Site.find :all
    headers["Content-Type"] = "text/xml; charset=utf-8"
    respond_to{ |format| format.xml}
  end
  
  def create_sitemap
    
    begin
      Site.create_sitemap
      render :nothing => true,:status=>200
    rescue
      render :nothing => true,:status=>500
    end
  end
  
  private
  def smr(tree,site)
      return if site.priority == 0
      if site.children_count > 0 then
        tree.li{
          tree.a(
            site.name,
            :href => url_for(
             :controller =>site.controller,
              :action=>site.action,
              :id=>site.item_id,
              :page=>site.menu_page
            ),
            :title=>site.description
          )
        }
        tree.ul{
            site.children.each{|c|
              smr(tree,c)
            }
        }
      else
        tree.li{
          tree.a(
            site.name,
            :href => url_for(
             :controller =>site.controller,
              :action=>site.action,
              :id=>site.item_id,
              :page=>site.menu_page
            ),
            :title=>site.description
          )
        }
      end
  end
end
