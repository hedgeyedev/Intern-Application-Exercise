class SessionsController < ApplicationController

  def index
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to posts4comments_url
  end


end
