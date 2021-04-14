class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def edit; end
end
