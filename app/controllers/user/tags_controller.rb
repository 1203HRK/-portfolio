class User::TagsController < ApplicationController
  def index
    @tags = Tag.order('tag_name')
  end

  def show
    @tag = Tag.find(params[:id])
    @reviews = @tag.reviews
    @tag_ranks = @reviews.order('likes_count desc')
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to tags_path
  end
end
