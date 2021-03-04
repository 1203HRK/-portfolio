class Item < ApplicationRecord

  validates :name, presence: true

  has_many :reviews, dependent: :destroy

      #itemの重複を調べて保存#
  def save_item(sent_items)
    current_items = Item.pluck(:name) unless Item.nil?
    old_items = current_items - [sent_items]
    new_items = [sent_items] - current_items

    old_items.each do |old|
      Item.delete Item.find_by(name: old)
    end

    new_items.each do |new|
      Item.find_or_create_by(name: new)
    end
    
    Item.find_by(name: sent_items)
    
  end

end
