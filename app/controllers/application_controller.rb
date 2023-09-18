class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:role])
  end

  protected

  def after_sign_in_path_for(resource)
    if resource.role == "customer"
      restaurants_path
    else
      manager_dashboard_path(resource)
    end
  end
end
