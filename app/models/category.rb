class Category < ApplicationRecord

  # ASSOCIATIONS
  belongs_to :restaurant
  has_many :products
end
