class ApplicationController < ActionController::Base
  def sign_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if cookies[:remember_token]
      @current_user ||= User.find_by(remember_token: cookies[:remember_token])
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


end
