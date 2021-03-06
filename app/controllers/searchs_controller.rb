class SearchsController < ApplicationController
  def search
    @range = params[:range]
    @word = params[:word]
    if @range == 'Tag'
      @tags = Tag.looks(params[:word])
    else
      @items = Item.looks(params[:word])
    end
  end
end
