class Post < ActiveRecord::Base
  attr_accessible :content, :title

  has_many :comments
end
