class AreaDetail < ActiveRecord::Base
  has_many :shops,foreign_key: :id
  belongs_to :areas,foreign_key: :area_id
end
