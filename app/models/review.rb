class Review < ApplicationRecord
  attachment :image
  accepts_nested_attributes_for :item, allow_destroy: true
  accepts_attachments_for :review_images, attachment: :image

  validates :body, presence: true

  belongs_to :user
  belongs_to :item

  has_many :review_images, dependent: :destroy
  has_many :likes, dependent: :destroy　
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  has_many :comments, dependent: :destroy

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  # タグ
  def save_tag(sent_tags)
    current_tags = tags.pluck(:tag_name) unless tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      tags.delete Tag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_review_tag = Tag.find_or_create_by(tag_name: new)
      tags << new_review_tag
    end
  end
end
