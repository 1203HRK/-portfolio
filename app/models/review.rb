class Review < ApplicationRecord

  belongs_to :user
  belongs_to :item
  accepts_nested_attributes_for :item, allow_destroy: true

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  has_many :review_images, dependent: :destroy
  accepts_attachments_for :review_images, attachment: :image
  # 通知機能
  has_many :notifications, dependent: :destroy
  
  validates :body, presence: true
  

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

  # いいね通知機能
  # ! > メソッド内でデータ登録もやっているので、呼び出す際は気をつけるように
  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索（いいねを連打しても1度しか通知が行かない）
    temp = Notification.where(["visitor_id = ? and visited_id = ? and review_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        review_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

end