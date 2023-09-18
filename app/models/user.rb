class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ASSOCIATIONS
  has_one :restaurant

  # METHODS
  def has_restaurant?
    restaurant.present?
  end

  def customer?
    role == "customer"
  end

  def manager?
    role == "manager"
  end
end
