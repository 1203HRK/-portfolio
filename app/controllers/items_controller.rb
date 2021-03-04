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
  


end
