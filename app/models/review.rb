class Review < ApplicationRecord

  attachment :image

  validates :body, presence: true
  validates :image, presence: true

  belongs_to :user
  belongs_to :item
   accepts_nested_attributes_for :item, allow_destroy: true

  has_many :likes, dependent: :destroy
    def liked_by?(user)
      likes.where(user_id: user.id).exists?
    end

  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
    def save_tag(sent_tags)
      current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
      old_tags = current_tags - sent_tags
      new_tags = sent_tags - current_tags

      old_tags.each do |old|
        self.tags.delete Tag.find_by(tag_name: old)
      end

      new_tags.each do |new|
        new_review_tag = Tag.find_or_create_by(tag_name: new)
        self.tags << new_review_tag
      end
    end

  has_many :comments, dependent: :destroy

end
