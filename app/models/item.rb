class Item < ApplicationRecord
  has_many :reviews, dependent: :destroy

  validates :name, presence: true

  def self.looks(words)
    @item = Item.where('name LIKE ?', "%#{words}%")
  end
end
