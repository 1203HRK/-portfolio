class CreateReviewImages < ActiveRecord::Migration[5.2]
  def change
    create_table :review_images do |t|
      t.string :image_id
      t.integer :review_id
      t.references :review, foreign_key: true

      t.timestamps
    end
  end
end
