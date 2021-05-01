class Tag < ApplicationRecord
  has_many :tag_maps, dependent: :destroy
  has_many :reviews, through: :tag_maps

  def self.name_like(tag_name)
    where('tag_name LIKE ?', "%#{tag_name}%")
  end
end
