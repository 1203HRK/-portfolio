class TagMap < ApplicationRecord
  belongs_to :review
  belongs_to :tag
  
  validates :re_id, presence: true
  validates :tag_id, presence: true
  
end
