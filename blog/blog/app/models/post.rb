class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_rich_text :content
  validates :title, :post, presence: true, allow_blank: false

  before_validation :plain_post

  def plain_post
    if self.post.nil?
      text = self.rich_text_content.to_plain_text
      self.post = text
    end
  end

  def post_preview
    self.post.split(" ")[0..100].join(" ")
  end
end
