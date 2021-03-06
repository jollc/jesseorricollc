class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

	SESSION_RETAINED_KEYS = ["session_id", "_csrf_token", "flash"].freeze

  helper_method :current_user

  # if Rails.env.staging?
  #   http_basic_authenticate_with name: "patrick", password: "henry"
  # end

  before_action :authenticate_user!
  before_action :require_admin!
  before_action :require_sysadmin!

  rescue_from User::Unauthenticated,
    with: :unauthenticated!
  rescue_from User::Unauthorized,
    with: :unauthorized!

  private

  def sign_in!(user)
    Rails.logger.info "Handling user sign in: #{user.email}."
    session[:user_id] = user.id
    @current_user = user
  end

  def sign_out!
    Rails.logger.info "Handling user sign out."
    (session.keys - SESSION_RETAINED_KEYS).each {|key| session.delete(key)}
    @current_user = nil
  end

  def current_user
    return @current_user if @current_user
    return unless session[:user_id]
    @current_user = User.find_by(id: session[:user_id])
  end

  def authenticate_user!
    raise User::Unauthenticated unless current_user
  end

  def require_admin!
    authenticate_user!
    raise User::Unauthorized unless current_user.admin? || current_user.sysadmin?
  end

  def require_sysadmin!
    authenticate_user!
    raise User::Unauthorized unless current_user.sysadmin?
  end

  def unauthenticated!
    Rails.logger.info("Handling unauthenticated user.")
    respond_to do |format|
      format.html {
        flash[:warning] = "You must be logged in to do that."
        redirect_to new_session_url
      }
      format.js { head 401 }
      format.json { head 401 }
    end
  end

  def unauthorized!
    Rails.logger.info("Handling unauthorized user.")
    respond_to do |format|
      format.html {
        flash[:warning] = "You don't have permission to do that."
        redirect_to root_url
      }
      format.js { head 401 }
      format.json { head 401 }
    end
  end

  def set_active_link
    @active_link = controller_name
  end
end
