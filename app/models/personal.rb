class Personal < ApplicationRecord

  has_many :personal_users, dependent: :destroy
  has_many :users, through: :personal_users
  
  accepts_nested_attributes_for :personal_users, allow_destroy: true

end
