class DashboardController < ApplicationController
  def index
    add_breadcrumb 'Dashboard', :dashboard_index_url
    load_resources
    respond_to do |format|
      format.html
    end
  end

  def home
    respond_to do |format|
      format.html
    end
  end

  def load_resources
    @projects = @current_company.projects
    @sprints = @current_company.sprints
    @issues = @current_company.issues
  end

end
