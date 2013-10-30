# sitemap.xml
xml.instruct! :xml, :version=> '1.0', :encoding => 'UTF-8'
xml.urlset :xmlns => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  @sites.each do |s|
    xml.comment!(s.name)
    xml.url do
      xml.loc(
        url_for(
          :controller =>s.controller,
          :action=>s.action,
          :id=>s.item_id,
          :page=>s.menu_page,
          :only_path => false
        )
      )
      xml.changefreq s.change_freq
      xml.priority s.priority
    end  if s.priority > 0
  end
end
