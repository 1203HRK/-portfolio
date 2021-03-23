class ReviewsController < ApplicationController
  before_action :authenticate_user!, {only: [:new, :edit, :update]}

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
      redirect_to users_path, success: '投稿完了！'
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
    # 重複している　＝　チェック処理　2件以上あればfalse 以外はtreu を書く　？→三項演算子
    @isDuplicated = Review.where(item_id: @item.id).size >= 2
  end

  def update
    review = Review.find(params[:id])
    tag_list = params[:review][:tag_name].split(/[[:blank:]]+/).select(&:present?)
    item = review.item
    if review.update(review_params)
      review.save_tag(tag_list)
      item.save
      redirect_to users_path, success: '編集できました！'
    else
      render :edit
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to users_path
  end

  private

  def review_params
    params.require(:review).permit(:body, :rate, item_attributes: %i[name _destroy id], review_images_images: [])
  end
end
