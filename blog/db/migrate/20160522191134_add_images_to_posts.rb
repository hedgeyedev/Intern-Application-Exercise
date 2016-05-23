class AddImagesToPosts < ActiveRecord::Migration
  def up
  	add_attachment :posts, :featured_image
  	add_attachment :posts, :author_image
  end

  def down
  	remove_attachment :posts, :featured_image
  	remove_attachment :posts, :author_image
  end
end
