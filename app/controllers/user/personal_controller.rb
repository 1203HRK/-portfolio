class User::PersonalController < ApplicationController
  def index
    @personals = Personal.all
  end

  def show
    @personal = Personal.find(params[:id])
    @reviews =  Review.joins(user: :personal_users).where(user: { personal_users: { personal: @personal } })
    @personal_ranks = Review.joins(user: :personal_users).where(user: { personal_users: { personal: @personal } }).order('likes_count desc')
  end

  def select
    @user = current_user
  end

  private

  def personal_params
    params.require(:personal).permit(:name, :description, { personal_ids: [] })
  end
end
