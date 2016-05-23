class AddCommentsToPosts < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.string :name
      t.text :content
      t.references :post

      t.timestamps null: false
    end
  end

  def down
  	drop_table :comments
  end
end
