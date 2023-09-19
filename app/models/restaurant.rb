class Restaurant < ApplicationRecord

  extend FriendlyId
  friendly_id :unique_hash, use: :slugged

  # METHODS
  def unique_hash
    loop do
      random_number = SecureRandom.hex(6)
      break random_number unless Restaurant.exists?(slug: random_number)
    end  
  end

  # VALIDATIONS
  validates_presence_of :title
  validates_presence_of :user_id

  has_one_attached :image
  
  # ASSOCIATIONS
  belongs_to :user
  has_many :categories
  has_many :products
  has_many :tables
end
