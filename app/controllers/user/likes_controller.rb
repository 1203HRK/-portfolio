class User::LikesController < ApplicationController
  before_action :review_params

  def create
    @like = Like.create(user_id: current_user.id, review_id: @review.id)
    # 通知機能
    @review.create_notification_like!(current_user)
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, review_id: @review.id)
    @like.destroy
  end

  private

  def review_params
    @review = Review.find(params[:review_id])
  end
end
