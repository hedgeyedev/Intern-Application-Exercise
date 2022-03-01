class Post < ApplicationRecord
  belongs_to :user
  validates :title, :post, presence: true, allow_blank: false
end
