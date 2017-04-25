class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.string :title
      t.text :content

      t.timestamps null: false
    end
  end

  def down
  	drop_table :posts
  end
end
