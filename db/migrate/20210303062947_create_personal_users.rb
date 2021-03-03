class CreatePersonalUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :personal_users do |t|
     t.references :personal, index: true
     t.references :user, index: true
     t.timestamps
    end
  end
end
