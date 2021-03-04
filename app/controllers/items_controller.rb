class ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def create
    item = Item.new(item_params)
    item_list = params[:item][:name]  
    item.save_item(item_list)  
    redirect_to items_path
  end

  def index
    @items =Item.all
  end

  def show
    @item = Item.find(params[:id])
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to items_path
    else
      render :edit
    end
  end
  

  

  private

  def item_params
    params.require(:item).permit(:name)
  end
  
    #itemの重複を調べて保存#
  def save_item(sent_items)
    current_items = self.items.pluck(:name) unless self.items.nil?
    old_items = current_items - sent_items
    new_items = sent_items - current_items
　
    old_items.each do |old|
      self.items.delete Item.find_by(name: old)
    end
　
    new_items.each do |new|
      new_item = Item.find_or_create_by(name: new)
      self.items << new_item
    end
  end

end
