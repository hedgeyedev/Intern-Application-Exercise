class RemoveStringFromPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :string, :string
  end
end
