class Post < ApplicationRecord
  has_rich_text :content
  has_many :comments, dependent: :destroy
end
