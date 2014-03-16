class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content

t.timestamps :created_at, :updated_at
    end
  end
end
