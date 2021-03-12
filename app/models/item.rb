class Item < ApplicationRecord
  validates :name, presence: true

  has_many :reviews, dependent: :destroy

  def self.looks(words)
    @item = Item.where('name LIKE ?', "%#{words}%")
  end
end
