class SessionsController < ApplicationController
  skip_before_filter :require_login

  def create
    user_params = params.require(:user)
    user = User.confirm(user_params[:email], user_params[:password])
    if user
      login(user)
      redirect_to user_path(user)
    else
      flash[:error] = "Failed to authenticate. Please try again."
      redirect_to root_path
    end
  end

  def destroy
    logout
    redirect_to root_path
    flash[:success] = "Successfully logout."
  end
end
