class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  attachment :profile_image
         
  has_many :personal_users
  has_many :personals, through: :personal_users
  
  has_many :reviews, dependent: :destroy
  
  has_many :likes, dependent: :destroy
  
end
