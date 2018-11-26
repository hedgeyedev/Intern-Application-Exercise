require "rails_helper"
require 'spec_test_helper'



RSpec.feature "Creating Posts" do 
	before do
		user_test2 = User.create(email: "user@test.com", password: "password", password_confirmation: "password")
		visit "/login"
		fill_in :email, with: 'user@test.com'
		fill_in :password, with: 'password'
		click_on 'Login!'
	end

	scenario "A user creates a new post" do
	visit "/"
	click_link "Create Post"
	fill_in "Title", with: "Creating a blog post" 
	fill_in "Content", with: "Lorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem Ipsum" 
	click_button "Create Post"
	expect(page).to have_content("Your post was successfully created!")
	expect(page.current_path).to eq("/posts/1") 
	end

	scenario "A user fails to create a new post" do
	visit "/"
	click_link "Create Post"
	fill_in "Title", with: "" 
	fill_in "Content", with: "" 
	click_button "Create Post"
	expect(page).to have_content("Title : all the fields must be filled up, Title : title must be between 2 and 40 characters, Content : all the fields must be filled up, and Content : content must be between 100 and 5,000 characters")
	expect(page.current_path).to eq(new_post_path) 
	end
end