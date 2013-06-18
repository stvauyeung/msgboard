class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to '/', :flash => {:success => "Welcome to the community!"}
    else
      @user.errors.messages.shift
      flash.now[:error] = "#{@user.errors.full_messages}"
      render :action => :new
    end
  end
end