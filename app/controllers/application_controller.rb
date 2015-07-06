class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  def authorize_admin!
    if current_user.nil? or !current_user.is_admin?
      flash[:notice] = "You are not authorized to view this resource."
      redirect_to root_path
    end
  end

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(
        :username,
        :email,
        :password,
        :password_confirmation,
        :profile_photo
      )
    end
    devise_parameter_sanitizer.for(:account_update) << :username
  end
end
