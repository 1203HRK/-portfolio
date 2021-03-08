class UsersController < ApplicationController

  def show #各ユーザーのプロフィール画面
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
