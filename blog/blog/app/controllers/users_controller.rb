class UsersController < ApplicationController

	def new
	end

	def create
		user = User.new(
			email: params[:email],
			password: params[:password],
			password_confirmation: params[:password_confirmation]
		)
		if user.save
			session[:user_id] = user.id 
			flash[:notice] = "You signed up successfully!"
			redirect_to "/posts"
		else
			flash[:error] = user.errors.full_messages.to_sentence
			redirect_to "/signup"
		end
	end
end
