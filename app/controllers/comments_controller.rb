class CommentsController < ApplicationController
  
  def create
    @review = Review.find(params[:review_id]) 
    @comment = @review.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      render :index
    end
  end
  
  def edit
  end
  
  def updated
    
  end
  
  def destroy
    @comment = Comment.find(params[:id]) 
    if @comment.destroy
      render :index
    end
  end

  private
  
    def comment_params
      params.require(:comment).permit(:comment, :review_id, :user_id)
    end
    
  
end
