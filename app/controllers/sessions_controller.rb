class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      sign_in user
      remember user
      current_user=(user)
    else
      render 'new'
    end
  end

  def destroy
    sign_out
    # debugger
    redirect_to login_path
  end



  private
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
