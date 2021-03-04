class AddReviewIdToItems < ActiveRecord::Migration[5.2]
  def change
     add_reference :items, :review, foreign_key: true
  end
end
