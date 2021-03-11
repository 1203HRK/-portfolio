class HomeController < ApplicationController
  def top
    @reviews = Review.all
  end
end
