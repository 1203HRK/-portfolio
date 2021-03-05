class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @item = Item.new
  end

  def create
    @review = Review.new(review_params)
    @item = Item.new(name: params[:review][:items][:name])
    tag_list = params[:review][:tag_name].split(nil)
    @review.user_id = current_user.id
    @item = @item.save_item(params[:review][:items][:name])
    @review.item_id = @item.id
    if @review.save
      @review.save_tag(tag_list)
      redirect_to review_path(@review.id) #とりあえず投稿詳細画面、あとでTLにしたい
    else
      render :new
    end
  end

  def index
  end

  def show
    @review = Review.find(params[:id])
    @user = @review.user
    @review_tags = @review.tags
    @item = @review.item
  end

  def edit
    @review = Review.find(params[:id])
    @item = @review.item
    @tag_list = @review.tags.pluck(:tag_name).split(nil)
  end
  
  def update
    review = Review.find(params[:id])
    @tag_list = params[:review][:tag_name].split(nil)
    if review.update(review_params)
      @review.save_tag(tag_list)
      redirect_to review_path(@review.id) #とりあえず投稿詳細画面、あとでTLにしたい
    else
      render :edit
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to user_path #とりあえずマイページ、あとでTLにしたい
  end


  private

  def review_params
    params.require(:review).permit(:body, :image, :description, { personals_ids: [] }, items_attributes: [:name, :_destroy, :id] )
  end

end
