class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?, :owner?
  before_filter :sidebar_objects
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user #guarantees a response of true or false
  end
  
  def require_user
    unless logged_in?
      flash[:error] = "You must be logged in to do that!"
      redirect_to login_path
    end
  end

  def owner? #for post view
    current_user == Post.find(params[:id]).user
  end

  def require_owner
    unless owner?
      flash[:error] = "You can only edit your own posts!"
      redirect_to post_path
    end
  end

  def sidebar_objects
    @sbcomments = Comment.find(:all, :order => "id desc", :limit => 5).reverse
  end

end
