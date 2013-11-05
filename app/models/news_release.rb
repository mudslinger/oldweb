class NewsRelease < ActiveRecord::Base
  scope :headline, -> {
    order("release_date desc").limit(10)
  }
  scope :ir, -> {
    where(news_type: 1)
  }
  scope :promo, -> {
    where(news_type: 0)
  }
  scope :newest, ->(num=30){
    order(:release_date).last(num).reverse
  }
end
