require "rails_helper"
require "spec_test_helper"
require "spec_helper"

RSpec.feature "Listing Posts" do 
	before  do 

		user_test2 = User.create(email: "user@test.com", password: "password", password_confirmation: "password")
		visit "/login"
		fill_in :email, with: 'user@test.com'
		fill_in :password, with: 'password'
		click_on 'Login!'

		visit "/"
		click_on 'Create Post'
		fill_in "Title", with: "first article test"
		fill_in "Content", with: "first content text.first content text.first content text.first content text.first content text.first content text.first content text.first content text.first content text.first content text."
		click_on 'Create Post'

	end
	scenario "A User lists all posts" do
	visit "/"
	expect(page).to have_content("first article test")
	expect(page).to have_content("first content text.")
\
	end
end