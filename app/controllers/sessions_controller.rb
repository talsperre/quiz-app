class SessionsController < ApplicationController
  before_action :logged_out_user,only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  def extauth
    user = User.from_omniauth(request.env["omniauth.auth"])
    puts(user)
    #debug(user.id)
    log_in user
    redirect_back_or user
  end

end
