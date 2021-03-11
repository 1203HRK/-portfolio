class Tag < ApplicationRecord
  has_many :tag_maps, dependent: :destroy
  has_many :reviews, through: :tag_maps

  def self.looks(searches, words)
    @tag = if searches == 'perfect_match'
             Tag.where('tag_name LIKE ?', words.to_s)
           else
             Tag.where('tag_name LIKE ?', "%#{words}%")
           end
  end
end
