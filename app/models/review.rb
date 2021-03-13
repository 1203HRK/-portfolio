class Review < ApplicationRecord

  validates :body, presence: true

  belongs_to :user
  belongs_to :item
   accepts_nested_attributes_for :item, allow_destroy: true

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  has_many :review_images, dependent: :destroy
  accepts_attachments_for :review_images, attachment: :image

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  #いいねのランキング取得
  def self.create_all_ranks
    Review.order('likes_count desc')
  end

  #アイテムだけのいいねのランキング取得
  def self.create_item_ranks(item_id)
   Review.where(item_id: item_id).order('likes_count desc')
  end

  #タグ登録、既存か新規か判断
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



end