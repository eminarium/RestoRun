class Product < ApplicationRecord

  # VALIDATIONS
  validates_presence_of :title
  validates_presence_of :category_id
  validates_presence_of :restaurant_id
  validates_presence_of :price
  validates :price, numericality: { greater_than: 0 }

  # ASSOCIATIONS
  belongs_to :category
  belongs_to :restaurant
end
