class Personal < ApplicationRecord

  has_many :personal_users, dependent: :destroy
  has_many :users, through: :personal_users
  accepts_nested_attributes_for :personal_users, allow_destroy: true
  
  has_many :personal_reviews, dependent: :destroy
  has_many :reviews, through: :personal_reviews
  accepts_nested_attributes_for :personal_reviews, allow_destroy: true

end
