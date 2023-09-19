class Category < ApplicationRecord

  extend FriendlyId
  friendly_id :title, use: :slugged

  # VALIDATIONS
  validates_presence_of :title
  validates_presence_of :restaurant_id

  # ASSOCIATIONS
  belongs_to :restaurant
  has_many :products
end
