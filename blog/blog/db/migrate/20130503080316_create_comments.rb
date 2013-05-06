class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.string :source
      t.text :comment
      t.integer :post_id

      t.timestamps
    end
  end
end
