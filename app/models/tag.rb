class Tag < ApplicationRecord
  
  has_many :tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :reviews, through: :tag_maps
  
  def self.looks(searches, words)
    if searches == "perfect_match"
      @tag = Tag.where("tag_name LIKE ?", "#{words}")
    else
      @tag = Tag.where("tag_name LIKE ?", "%#{words}%")
    end
  end
  
end
