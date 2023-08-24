class Restaurant < ApplicationRecord

  # ASSOCIATIONS
  belongs_to :user
  has_many :categories
end