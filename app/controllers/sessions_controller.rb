class SessionsController < ApplicationController
  layout 'sessions'

  skip_before_action :authenticate_user!,
    only: %w(new create)
  skip_before_action :require_admin!
  skip_before_action :require_sysadmin!

  def new
    if current_user
      redirect_to root_url(subdomain: 'admin')
      return
    end
  end

  def create
    @user = User.find_by(email: params[:email].to_s.strip.downcase)

    if @user && @user.authenticate(params[:password])
      sign_in! @user
      redirect_to root_url(subdomain: 'admin')
    else
      render :new
    end
  end

  def destroy
    sign_out!
    redirect_to root_url(subdomain: 'www')
  end
end
