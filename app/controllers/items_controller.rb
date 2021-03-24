class ItemsController < ApplicationController
  before_action :autheniticate_user, {only: [:edit, :update, :destroy]}

  def new
    @item = Item.new
  end

  def create
    Item.find_or_create_by(item_params)
    redirect_to items_path
  end

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    # アイテムIDに紐づいたレビュー
    @reviews = @item.reviews
    @item_ranks = Review.create_item_ranks(@item.id)
    @average = @item.reviews.average(:rate).to_f.round(1)
    @personals = Personal.all

    # show page users
    user_ids = @reviews.pluck('user_id')
    personal_user_ids = PersonalUser.where(user_id: user_ids.uniq).pluck('personal_id')
    @personal = Personal.where(id: personal_user_ids)
    @personal_all_users = {}
    # @personal 'イエローベース', ブルーベース,,,etc
    @personal.each do | personal |
      @personal_all_users[personal.name] = PersonalUser.where(personal_id: Personal.where(name: personal.name).pluck('id')).pluck('user_id')
    end
    #personal_all_users {"ブルーベース"=>[1, 2, 3], "spring"=>[1, 2, 3]}
    #hash[key] = value
    #{key => value}
    @personal_and_review_counts = {}
    # user_ids [5,5,5]
    user_ids.each.with_index(1) do | id, index |
      @personal_all_users.each do |personal_name, user_ids|
        @personal_and_review_counts[personal_name] = 0 if index == 1
        @personal_and_review_counts[personal_name] += user_ids.count(id)
      end
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to items_path
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:name)
  end
end
