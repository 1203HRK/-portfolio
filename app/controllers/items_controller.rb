class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    Item.find_or_create_by(item_params)
    redirect_to items_path
  end

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @reviews = @item.reviews
    @item_ranks = Review.create_item_ranks(@item.id)
    @average = @item.reviews.average(:rate).to_f.round(1)
    @personals = Personal.all
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
  
  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to items_path
  end
  

  private

  def item_params
    params.require(:item).permit(:name)
  end
end
