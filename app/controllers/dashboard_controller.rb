class DashboardController < ApplicationController
  def index
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
    @projects = Company.current_company.projects
    @sprints = Sprint.all
    @issues = Company.current_company.issues
  end

end
