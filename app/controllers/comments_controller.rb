class CommentsController < ApplicationController
  
  def create
    review = Review.find(params[:review_id]) 
    comment = current_user.comments.new(comment_params)
    comment.review_id = review.id
    comment.save
    redirect_to review_path(review)
  end
  
  def edit
  end
  
  def updated
    
  end
  
  def destroy
    review = Review.find(params[:review_id]) 
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to review_path(review)
  end
  
    private

  def comment_params
    params.require(:comment).permit(:comment)
  end
  
end
