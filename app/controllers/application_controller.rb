class ApplicationController < ActionController::Base
  around_action :set_tenant_id
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActionController::UnknownFormat do |exception|
    flash[:alert] = exception.message
    redirect_to root_url
  end


  def set_tenant_id
    Company.current_company_id = current_company&.id
    yield
  ensure
    Company.current_company_id = nil
  end

  def current_company

    @current_company ||=
      case request.subdomain
      when 'www', '', nil
        nil
      else
        Company.find_by!(subdomain: request.subdomain) 
      end
  end

  def after_sign_in_path_for(resource)
    users_path
  end

   protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :phone_num, company_attributes: [:name, :subdomain])}

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}

  end
end