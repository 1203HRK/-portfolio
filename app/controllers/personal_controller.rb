class PersonalController < ApplicationController


  def show
    @personals = Personal.all
    #@personal.user_id = personal_user.id
  end

  def select
    @user = current_user
  end

   private

  def personal_params
    params.require(:personal).permit(:name, :description,  { personal_ids: [] })
  end

end
