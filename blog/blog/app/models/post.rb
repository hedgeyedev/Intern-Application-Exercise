class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, :post, presence: true, allow_blank: false

  def post_introduction
    self.post 
    post.split(" ")[0..10].join(" ")
  end
end
