class User::CommentsController < ApplicationController
  
  def create
    @review = Review.find(params[:review_id])
    @comment = @review.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      @review.create_notification_comment!(current_user, @comment.id) # 通知機能
      @comments = @comment.review.comments.order(created_at: :desc) # 作成日新着順
      render :index
    else
      render 'show'
    end
  end

  def edit; end

  def updated; end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @comments = @comment.review.comments.order(created_at: :desc) # 作成日新着順
    render :index
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :review_id, :user_id)
  end
end
