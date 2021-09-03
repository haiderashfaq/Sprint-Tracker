class ApplicationController < ActionController::Base
  around_action :set_tenant_id
  before_action :authenticate_user!
  rescue_from ActionController::UnknownFormat do |exception|
    flash[:alert] = exception.message
    redirect_to root_url
  end

  def set_tenant_id
    Company.current_company_id = current_company.id
    yield
  ensure
    Company.current_company_id = nil
  end

  private

  def current_company
    @current_company ||= Company.find_by!(subdomain: request.subdomain)
  end
end
