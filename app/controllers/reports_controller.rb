class ReportsController < ApplicationController
  before_action :load_data
  before_action :add_breadcrumbs, only: [:index, :sprint_report]
  def index
    respond_to do |format|
      format.html
    end
  end

  def sprint_report
    unless params[:sprint_id].nil?
      @sprint = @sprints.find_by(id: params[:sprint_id])
      @sprint_report_attributes = @sprint.issues.left_outer_joins(:time_logs).group('issues.assignee_id').select("issues.*, sum(time_logs.logged_time) as total_time_spent, count(*) AS total_issues, count('Open') as open_issues, count('Resolved') as resolved_issues, sum(estimated_time) as total_estimated_time").paginate(page: params[:page])
    end
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data ReportCsv.new(Report::SPRINT_HEADERS, @sprint_report_attributes).to_csv, :type => 'text/csv;', filename: "sprint_report-#{Date.today}.csv" }
    end
  end

  def issue_report
    unless params[:sprint_id].nil?
      @sprint = @sprints.find_by(id: params[:sprint_id])
      @issue_report_attributes = @sprint.issues.order("assignee_id DESC").select("issues.*").paginate(page: params[:page])
    end
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data ReportCsv.new(Report::ISSUE_HEADERS, @issue_report_attributes).to_csv, type: 'text/csv;', filename: "issues_report-#{Date.today}.csv" }
    end
  end

  def load_data
    @issues = Issue.accessible_by(current_ability)
    @sprints = Sprint.accessible_by(current_ability)
    @users = User.accessible_by(current_ability)
  end

  def reports_param
    params.require(:issue).permit(:sprint_id)
  end

  def add_breadcrumbs
    binding.pry
    path = request.url.split('/')
    path.drop(3).each do |route|
    		if params[:sprint_id]
    			add_breadcrumb route.titleize, sprint_path(@sprint)
    		else
      	add_breadcrumb route.titleize, :"#{route}_path"
    	end
    end
  end
end
