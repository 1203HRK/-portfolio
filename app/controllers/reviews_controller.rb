class ReviewsController < ApplicationController
  
  def new
    @review = Review.new
    @item = Item.new
  end
  
  def create
    @review = Review.new(review_params)
    tag_list = params[:review][:tag_name].split(nil) 
    if @review.save
      @review.save_tag(tag_list) 
      redirect_to review_path(review.id) #とりあえず投稿詳細画面、あとでTLにしたい
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
  end

  def edit
  end
  
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags
　
    old_tags.each do |old|
      self.review_tags.delete ReviewTag.find_by(tag_name: old)
    end
　
    new_tags.each do |new|
      new_review_tag = ReviewTag.find_or_create_by(tag_name: new)
      self.review_tags << new_review_tag
    end
  end
  
  private

  def review_params
    params.require(:review).permit(:body, :image, :description, { personals_ids: [] }, items_attributes: [:name, :_destroy, :id] )
  end
  
end
