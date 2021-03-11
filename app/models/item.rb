class Item < ApplicationRecord
  validates :name, presence: true

  has_many :reviews, dependent: :destroy

  def self.looks(searches, words)
    @item = if searches == 'perfect_match'
              Item.where('name LIKE ?', words.to_s)
            else
              Item.where('name LIKE ?', "%#{words}%")
            end
  end
end
