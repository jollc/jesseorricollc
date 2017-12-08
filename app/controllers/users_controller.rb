class UsersController < ApplicationController

  skip_before_action :authenticate_user!,
    only: %w(new create)
  skip_before_action :require_admin!,
    only: %w(new create edit update)
  skip_before_action :require_sysadmin!,
    only: %w(new create edit update)

  def index
    @users = User.order(email: :asc).page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    #if @user.update(admin_user_params)
    if @user.update(user_params)
      redirect_to edit_user_url(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])

    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  # Anyone can access, external of application
  #
  # NOTE: This probably needs to be updated to admin only, and send through
  # a password setting process the first time the user signs in.
  #
  def new
    @user = User.new
  end

  # Anyone can access, external of application
  #
  def create
    @user = User.new(user_params)

    # if @user.save
    #   sign_in! @user
    #   redirect_to root_url(subdomain: 'admin')
    # else
    #   render :new
    # end

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_url(subdomain: 'admin'), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email, :name, :password, :password_confirmation, :admin, :sysadmin
    )
  end

  def admin_user_params
    params.require(:user).permit(
      :admin, :sysadmin
    )
  end
end
