class ApplicationController < ActionController::Base
  around_action :set_tenant_id

  before_action :authenticate_user!, except: [:list_companies]

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
  rescue_from ActionController::UnknownFormat do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    flash[:error] = exception.message
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
      if SUBDOMAIN_OPTIONS.include? request.subdomain
        nil
      else
        Company.find_by!(subdomain: request.subdomain)
      end
  end

  def after_sign_in_path_for(resource)
    root_path
  end
end
