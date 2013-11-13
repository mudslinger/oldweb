class SiteController < ApplicationController
  before_filter :force_plain
  anot :sitemap , parent: 'top#index',title:'サイトマップ'
  def sitemap
    @sitemap = generate_sitemap
  end
  anot :about , parent: 'top#index',title:'このホームページについて'
end
