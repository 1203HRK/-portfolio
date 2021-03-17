class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review

  # 通知機能
  has_many :notifications, dependent: :destroy

  validates :comment, length: { in: 1..75 }
end
