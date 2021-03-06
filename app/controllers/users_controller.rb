class UsersController < ApplicationController
  def index
    @user = current_user
    # フォローユーザーと自分のIDをまとめた。
    # pluck -> 引数で与えたカラムの値だけをとって配列で返す
    follower_ids = @user.following.pluck(:id)
    follower_ids.push(@user.id)
    @reviews = Review.where(user_id: follower_ids).order(id: 'desc')
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @likes = Like.where(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  # @userがフォローしているユーザー
  def following
    @user  = User.find(params[:id])
    @users = @user.following
  end

  # @userをフォローしているユーザー
  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, { personal_ids: [] })
  end
end
