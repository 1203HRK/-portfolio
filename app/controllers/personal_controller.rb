class PersonalController < ApplicationController


  def show
    @personals = Personal.all
  end

  #一旦保留もしかしたらuserのviewかも

  #def select
  #   @personals = Personal.all
  #end

  # private

  #def personal_params
  #  params.require(:personal).permit(:name, :description,  { personal_ids: [] })
  #end

end
