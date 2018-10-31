class User < ApplicationRecord
	validates_presence_of :email, :password, :password_confirmation, :message => ": all the fields must be filled up"
	validates_format_of   :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/, :message => ": email format incorrect"
	validates_uniqueness_of :email, :message => ": you already signed up with this email"
	validates_length_of :password, minimum: 6, maximum: 20, :message => ": password must be between 6 and 20 characters"
	has_secure_password
	has_many :posts
end
