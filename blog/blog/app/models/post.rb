class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_rich_text :post
  validates :title, :post, presence: true, allow_blank: false
end
