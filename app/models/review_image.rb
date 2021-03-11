class ReviewImage < ApplicationRecord
  attachment :image

  belongs_to :review
end
