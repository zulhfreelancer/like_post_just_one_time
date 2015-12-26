class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :text
      t.integer :user_id
      t.integer :like
      t.integer :dislike

      t.timestamps null: false
    end
  end
end
