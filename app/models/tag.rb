class Tag < ApplicationRecord
  has_many :tag_maps, dependent: :destroy
  has_many :reviews, through: :tag_maps

  def self.looks(words)
    @tag = Tag.where('tag_name LIKE ?', "%#{words}%")
  end
end
