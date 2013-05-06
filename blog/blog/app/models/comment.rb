class Comment < ActiveRecord::Base
  belongs_to :post
  attr_accessible :comment, :name, :post_id, :source
end
