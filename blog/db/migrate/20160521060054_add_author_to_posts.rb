class AddAuthorToPosts < ActiveRecord::Migration
  def up
  	add_column :posts, :author, :string
  end

  def down
  	remove_column :posts, :author
  end
end
