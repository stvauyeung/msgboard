class SessionsController < ApplicationController
  def new
    
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Hello, #{user.username}!"
    else
      flash.now[:error] = "Sorry, username or password was incorrect.  Please try again."
      render 'sessions/new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, :notice => "You've successfully signed out."
  end
end