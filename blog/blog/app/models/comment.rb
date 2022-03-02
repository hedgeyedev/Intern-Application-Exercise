class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :comment, presence: true, allow_blank: false
end
