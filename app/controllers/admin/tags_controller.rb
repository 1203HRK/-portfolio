class Admin::TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    tag = Tag.find(params[:id])
    if tag.save
      redirect_to admin_tags_path
    else
      render :edit
    end
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to admin_tags_path
  end
end
