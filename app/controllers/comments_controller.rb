class CommentsController < ApplicationController
  
  def create
    @review = Review.find(params[:review_id]) 
    @comment = @review.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_back(fallback_location: root_path)
  end
  
  def edit
  end
  
  def updated
    
  end
  
  def destroy
    @comment = Comment.find(params[:id]) 
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private
  
    def comment_params
      params.require(:comment).permit(:comment, :review_id, :user_id)
    end
    
  
end
