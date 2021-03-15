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
  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :following, through: :following_relationships
  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationships
  
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
