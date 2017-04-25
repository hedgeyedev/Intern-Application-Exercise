class AddReadersToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :readers, :integer
  end
end
