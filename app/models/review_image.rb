class ReviewImage < ApplicationRecord
  belongs_to :review

  attachment :image

  # そのうち画像にもバリデーション
end
