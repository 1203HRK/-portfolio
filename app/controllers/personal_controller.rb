class PersonalController < ApplicationController


  def show
    @personals = Personal.all
  end

  def select
    @user = current_user
  end

   private

  def personal_params
    params.require(:personal).permit(:name, :description,  { personal_ids: [] })
  end

end
