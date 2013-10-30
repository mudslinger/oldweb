class SiteController < ApplicationController

  anot :sitemap , parent: 'top#index',title:'サイトマップ'
  def sitemap
    @sitemap = generate_sitemap
  end

end
