class AddDefaultToPostLikeAndDislike < ActiveRecord::Migration
  def change
  	change_column :posts, :like, :integer, :default => 0
  	change_column :posts, :dislike, :integer, :default => 0
  end
end
