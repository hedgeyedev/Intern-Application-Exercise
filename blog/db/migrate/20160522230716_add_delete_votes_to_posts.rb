class AddDeleteVotesToPosts < ActiveRecord::Migration
  def up
  	add_column :posts, :delete_votes, :integer, default: 0
  end

  def down 
  	remove_column :posts, :delete_votes
  end
end
