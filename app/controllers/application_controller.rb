class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  around_action :set_tenant_id

  def set_tenant_id
    Company.current_company = current_company.id
    yield
  ensure
    Company.current_company = nil
  end

  private

  def current_author
    Company.find_by_subdomain(request.subdomain)
  end
end
