class SessionsController < ApplicationController

	def new
	end

	def create
	 user = User.find_by(email: params[:email])
	 # need bootstrap gem
	 if user && user.authenticate(params[:password])
	  session[:user_id] = user.id
	  flash[:success] = "You logged in successfully!"
	  redirect_to "/posts"
	 else
	  flash[:warning] = "Invalid Username or Password"
	  redirect_to "/login"
	 end
	end

	def destroy
	  session[:user_id] = nil
	  flash[:success] = "You logged out successfully!"
	  redirect_to "/posts"
	end

end
