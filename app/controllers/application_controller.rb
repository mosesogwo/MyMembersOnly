class ApplicationController < ActionController::Base
  def sign_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    remember_token = User.new_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_digest, User.digest(remember_token))
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies[:remember_token]
      @current_user ||= User.find_by(remember_token: User.digest(cookies[:remember_token].to_s))
    end
    @current_user
  end

  def current_user=(user)
    @current_user = user
  end

  def sign_out
    session.delete(:user_id)
    @current_user = nil
    cookies.delete(:remember_token)
  end

  def signed_in?
    redirect_to login_path unless !current_user.nil?
  end

  helper_method :signed_in?, :current_user

end
