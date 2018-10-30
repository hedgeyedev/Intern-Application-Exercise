class Comment < ApplicationRecord
	validates_presence_of :user_id, :message => ": all the fields must be filled up"
	validates_length_of :content, minimum: 2, maximum: 1000, :message => ": your comment must be between 2 and 1,000 characters"
	belongs_to :post
	belongs_to :user
end
