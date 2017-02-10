class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email])
  	if user && user.authenticate(params[:session][:password])
  		log_in(user)
      params[:session][:remember] == '1' ? remember(user) : forget(user)
  		redirect_user_or_default(user)
  	else
  		flash.now[:danger] = "Invalid email/password combination"
  		render 'new'
  	end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
