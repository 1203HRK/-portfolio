class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :body
      t.float :rate
      t.string :image
      
      t.timestamps
    end
  end
end
