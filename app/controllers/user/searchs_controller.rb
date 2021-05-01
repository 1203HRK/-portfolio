class User::SearchsController < ApplicationController
  def search
    @range = params[:range]
    @word = params[:word]
    if @range == 'Tag'
      @tags = Tag.name_like(params[:word])
    else
      @items = Item.name_like(params[:word])
    end
  end
end
