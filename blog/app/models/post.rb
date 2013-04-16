class Post < ActiveRecord::Base
  attr_accessible :content, :title
  validates :content,  presence: true, length: { maximum: 10000 }
  validates :title, presence: true, length: { maximum: 40 }
  has_many :comments , :dependent => :destroy, :order => "created_at DESC"

  def updated_at_formatted
    updated_at.to_formatted_s(:long_ordinal)
  end

  def no_of_comments
    comments.length
  end

end
