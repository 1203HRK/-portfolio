class HomeController < ApplicationController
  def top
    @all_ranks = Review.create_all_ranks
    # お問い合わせフォーム表示
    @inquiry = Inquiry.new
  end
end
