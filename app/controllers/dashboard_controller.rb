class DashboardController < ApplicationController
  def index
    add_breadcrumb 'Dashboard', :dashboard_index_url
    respond_to do |format|
      format.html
    end
  end

  def home
    respond_to do |format|
      format.html
    end
  end

end
