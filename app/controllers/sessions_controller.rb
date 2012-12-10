class SessionsController < ApplicationController

  def new
  end

  def create
    #user = User.where('lower(email) = ?', params[:session][:email].downcase).first
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
	  flash[:success] = "Welcome"
      redirect_back_or user
    else
      flash.now[:error] = "Invalid"
      render 'new'
    end
  end

  def destroy
	sign_out
	redirect_to root_path
  end
  
end
