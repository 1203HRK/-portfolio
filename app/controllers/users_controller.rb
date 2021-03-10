class UsersController < ApplicationController
  
  def index
    @user = current_user
    follower_ids = @user.following.pluck(:id)
    follower_ids.push(@user.id)
    @reviews = Review.where(user_id: follower_ids).order(id: "desc")
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end
  
  def following#@userがフォローしているユーザー
    @user  = User.find(params[:id])
    @users = @user.following
    
  end

  def followers#@userをフォローしているユーザー
    @user  = User.find(params[:id])
    @users = @user.followers
    
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, { personal_ids: [] })
  end

end
