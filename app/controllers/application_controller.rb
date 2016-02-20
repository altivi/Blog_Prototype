class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  

  before_action :search_met
  
  helper_method :current_user, :posts_list

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def posts_list
  	@posts = Post.all
  end


  def search_met
    @q = Post.ransack(params[:q])
  end

end
