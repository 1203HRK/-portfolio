class RenameImageColumnToReviews < ActiveRecord::Migration[5.2]
  def change
    rename_column :reviews, :image, :image_id
  end
end
