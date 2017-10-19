class CreateCandy < ActiveRecord::Migration
  def change
    create_table :candies do |t|
      t.integer :user_id
      t.string :name
    end
  end
end
