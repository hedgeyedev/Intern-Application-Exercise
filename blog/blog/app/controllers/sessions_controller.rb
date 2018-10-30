class SessionsController < ApplicationController

	# GET /sessions/new
	def new
	end
	
	# POST /sessions
	def create
	 user = User.find_by(email: params[:email])
	 if user && user.authenticate(params[:password])
	  session[:user_id] = user.id
	  flash[:notice] = "You logged in successfully!"
	  redirect_to "/posts"
	 else
	  flash[:error] = "Invalid Username or Password"
	  redirect_to "/login"
	 end
	end

	# DELETE /sessions/:id
	def destroy
	  session[:user_id] = nil
	  flash[:notice] = "You logged out successfully!"
	  redirect_to "/posts"
	end

end
