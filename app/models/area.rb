class Area < ActiveRecord::Base
  has_and_belongs_to_many :shops,->(record) {Shop.active},join_table: :area_details
  scope :sorted, -> {order(:soat_order)}
end
