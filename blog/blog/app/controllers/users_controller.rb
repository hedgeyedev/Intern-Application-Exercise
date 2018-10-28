class UsersController < ApplicationController

	def new

	end

	def create
		user = User.new(
			email: params[:email],
			password: params[:password],
			password_confirmation: params[:password_confirmation]
		)
		# require bootstrap gem
		if user.save
			session[:user_id] = user.id 
			flash[:success] = "You signed up successfully!"
			redirect_to "/posts"
		else
			flash[:warning] = "Invalid Email or Password"
			redirect_to "/signup"
		end
	end
end
