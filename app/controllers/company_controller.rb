class CompanyController < ApplicationController
  before_filter :force_plain
  anot :index , parent: 'top#index',title:'会社概要'
  def index
    @sales = [2934064,3998817,5100858,5959462,6444178,7033515,7223968,7952626,8712310,8909344]
    @profits = [104525,197538,271226,174968,92168,243433,393275,290018,57895,176058]
    s = Shop.new_shops
    puts s
    puts Rails.cache.read(:sitemap)
  end

  anot :greetings , parent: 'company#index',title:'ごあいさつ'
  def greetings
  end

  anot :history, parent: 'company#index',title:'ヒストリー'
  def history
    @shop_a = [18,20,20,22,24,35,45,54,67,77,84,91,102,121,137,137]
    @shop_b = [2,3,4,4,6,0,0,0,0,0,0,0,0,0,0,0]
    @shop_ttl = Array.new(16) { |idx|  @shop_a[idx] + @shop_b[idx]}
  end

  anot :sns_guideline, parent: 'company#index',title:'SNSガイドライン'
  def sns_guideline
  end

  anot :aniv_25, parent: 'company#index',title:'25周年記念'
  def aniv_25
  end
end
