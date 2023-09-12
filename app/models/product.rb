class Product < ApplicationRecord

  # ASSOCIATIONS
  belongs_to :category
  belongs_to :restaurant
end
