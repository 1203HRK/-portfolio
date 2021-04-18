class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end
  
  def show
    @item = Item.find(params[:id])
    @reviews = @item.reviews
  end

  def edit; end
end
