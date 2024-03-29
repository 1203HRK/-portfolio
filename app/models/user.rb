class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  attachment :profile_image

  has_many :personal_users, dependent: :destroy
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
  # SNS認証
  has_many :sns_credentials, dependent: :destroy

  validates :name, presence: true

  # ログインユーザーかどうか
  def me?(user_id)
   id == user_id
  end

  # ゲストログイン
  def self.guest
    find_or_create_by!(email: 'guest@example.com', name: 'ゲスト') do |user|
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

  # フォロー通知機能
  def create_notification_follow!(current_user)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and action = ? ', current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  # SNS認証
  def self.without_sns_data(auth)
    user = User.where(email: auth.info.email).first

    if user.present?
      sns = SnsCredential.create(
        uid: auth.uid,
        provider: auth.provider,
        user_id: user.id
      )
    else
      user = User.new(
        name: auth.info.name,
        email: auth.info.email
      )
      sns = SnsCredential.new(
        uid: auth.uid,
        provider: auth.provider
      )
    end
    { user: user, sns: sns }
  end

  def self.with_sns_data(auth, snscredential)
    user = User.where(id: snscredential.user_id).first
    if user.blank?
      user = User.new(
        name: auth.info.name,
        email: auth.info.email
      )
    end
    { user: user }
  end

  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    if snscredential.present?
      user = with_sns_data(auth, snscredential)[:user]
      sns = snscredential
    else
      user = without_sns_data(auth)[:user]
      sns = without_sns_data(auth)[:sns]
    end
    { user: user, sns: sns }
  end
end
