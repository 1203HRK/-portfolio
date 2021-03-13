class HomeController < ApplicationController
  def top
    @all_ranks = Review.create_all_ranks
  end
end
