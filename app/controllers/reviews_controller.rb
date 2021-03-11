class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @item = Item.new
  end

  def create
    @review = Review.new(review_params)
    @item = Item.find_or_create_by(name: params[:review][:items][:name])
    tag_list = params[:review][:tag_name].split(/[[:blank:]]+/).select(&:present?)
    @review.user_id = current_user.id
    @review.item_id = @item.id
    if @review.save
      @review.save_tag(tag_list)
      redirect_to review_path(@review.id) # とりあえず投稿詳細画面、あとでTLにしたい
    else
      render :new
    end
  end

  def index; end

  def show
    @review = Review.find(params[:id])
    @user = @review.user
    @review_tags = @review.tags
    @item = @review.item
    @comment = Comment.new
    @comments = @review.comments.order(created_at: :desc) # 作成日新着順
  end

  def edit
    @review = Review.find(params[:id])
    @item = @review.item
    @tag_list = @review.tags.pluck(:tag_name).split(/[[:blank:]]+/).select(&:present?)
  end

  def update
    review = Review.find(params[:id])
    tag_list = params[:review][:tag_name].split(/[[:blank:]]+/).select(&:present?)
    item = review.item
    if review.update(review_params)
      review.save_tag(tag_list)
      item.save
      redirect_to review_path(review.id) # とりあえず投稿詳細画面、あとでTLにしたい
    else
      render :edit
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to current_user # とりあえずマイページ、あとでTLにしたい
  end

  private

  def review_params
    params.require(:review).permit(:body, :rate, item_attributes: %i[name _destroy id], review_images_images: [])
  end
end
