class User::UsersController < ApplicationController
  before_action :authenticate_user!, {only: [:edit, :update]}
  
  def index
    @user = current_user
    # フォローユーザーと自分のIDをまとめた。
    # pluck -> 引数で与えたカラムの値だけをとって配列で返す
    follower_ids = @user.following.pluck(:id)
    follower_ids.push(@user.id)
    @reviews = Review.where(user_id: follower_ids).order(id: 'desc').limit(50)
    # @review_images = "noimage.jpg" 画像無しの時に表示したくて
    # @notifications = current_user.passive_notifications.where(checked: false)
    # notifications = @notifications.where.not(visitor_id: current_user.id)
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
    if @user.update(user_params)
      redirect_to user_path(@user.id), success: 'プロフィール編集完了！'
    else
      render 'edit'
    end
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
    params.require(:user).permit(:name, :profile_image, :introduction, { personal_ids: [] })
  end
end
