class Restaurant < ApplicationRecord

  # VALIDATIONS
  validates_presence_of :title
  validates_presence_of :user_id

  # ASSOCIATIONS
  belongs_to :user
  has_many :categories
  has_many :products
  has_many :tables
end
