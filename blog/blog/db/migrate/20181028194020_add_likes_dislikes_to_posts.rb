class AddLikesDislikesToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :likes, :integer, default: 0
    add_column :posts, :dislikes, :integer, default: 0
  end
end
