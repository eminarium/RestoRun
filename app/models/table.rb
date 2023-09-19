class Table < ApplicationRecord

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :title,
      [:title, restaurant.title]
    ]
  end

  # VALIDATIONS
  validates_presence_of :title
  validates_presence_of :restaurant_id

  # ASSOCIATIONS
  belongs_to :restaurant
end
