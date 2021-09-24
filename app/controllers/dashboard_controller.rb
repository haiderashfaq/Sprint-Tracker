class DashboardController < ApplicationController
  def index
    add_breadcrumb t('shared.dashboard'), :dashboard_index_url
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
    @projects = @current_company.projects.accessible_by(current_ability)
    @sprints = @current_company.sprints.accessible_by(current_ability)
    @issues = @current_company.issues.accessible_by(current_ability)
    @assigned_issues = Issue.accessible_by(current_ability).joins(:assignee).where(assignee_id: current_user.id).paginate(page: params[:page])
  end
end
