class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.integer :commenter_id
      t.integer :post_id
      t.integer :like
      t.integer :dislike

      t.timestamps
    end
  end
end
