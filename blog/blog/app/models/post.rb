class Post < ApplicationRecord
	validates_presence_of :title, :content, :message => ": All the fields must be filled up"
	validates_length_of :title, minimum: 2, maximum:40, :message => ": Title must be between 2 and 40 characters"
	validates_length_of :content, minimum: 100, maximum:5000, :message => ": Content must be between 100 and 5,000 characters"
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy
end
