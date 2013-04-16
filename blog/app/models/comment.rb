class Comment < ActiveRecord::Base
  belongs_to :post
  attr_accessible :body, :commenter
  validates :body,  presence: true, length: { maximum: 300 }
  validates :commenter, presence: true, length: { maximum: 10 }

  def created_at_formatted
     created_at.to_formatted_s(:long_ordinal)
  end
end
