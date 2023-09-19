class Category < ApplicationRecord

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :title,
      [:title, restaurant.slug]
    ]
  end

  # VALIDATIONS
  validates_presence_of :title
  validates_presence_of :restaurant_id

  # ASSOCIATIONS
  belongs_to :restaurant
  has_many :products
end
