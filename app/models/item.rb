class Item < ApplicationRecord
  has_many :reviews, dependent: :destroy

  validates :name, presence: true

  def self.name_like(name)
    where('name LIKE ?', "%#{name}%")
  end
end
