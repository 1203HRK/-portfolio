class Review < ApplicationRecord
  
  attachment :image
  
  validates :body, presence: true
  validates :image, presence: true
  
  belongs_to :user
  belongs_to :item
   accepts_nested_attributes_for :item, allow_destroy: true
  
  has_many :personal_reviews, dependent: :destroy
  has_many :personals, through: :personal_reviews
  
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  
 
  
end
