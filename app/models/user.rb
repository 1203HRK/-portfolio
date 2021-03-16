class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :personal_users
  has_many :personals, through: :personal_users
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  # フォロー機能
  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :following, through: :following_relationships
  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationships
  # 通知機能
  # 通知を送る
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  # 通知を受け取る
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  validates :name, presence: true

  # ゲストログイン
  def self.guest
    find_or_create_by!(email: 'guest@example.com', name:"ゲスト") do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def following?(user)
    following_relationships.find_by(following_id: user.id)
  end

  # フォローを外す
  def unfollow(user)
    following_relationships.find_by(following_id: user.id).destroy
  end

  # フォローする
  def follow(user)
    following_relationships.create!(following_id: user.id)
  end
end

  # フォロー通知機能
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end