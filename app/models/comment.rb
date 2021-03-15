class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  
  validates :comment, length: { in: 1..75 }
end
