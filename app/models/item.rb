class Item < ApplicationRecord

  validates :name, presence: true

  has_many :reviews, dependent: :destroy

  def self.looks(searches, words)
    if searches == "perfect_match"
      @item = Item.where("name LIKE ?", "#{words}")
    else
      @item = Item.where("name LIKE ?", "%#{words}%")
    end
  end

end
