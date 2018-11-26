class Post < ApplicationRecord
	validates_presence_of :title, :content, :message => ": all the fields must be filled up"
	validates_length_of :title, minimum: 2, maximum:40, :message => ": title must be between 2 and 40 characters"
	validates_length_of :content, minimum: 100, maximum:5000, :message => ": content must be between 100 and 5,000 characters"
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy

	default_scope { order(created_at: :desc)}
end
