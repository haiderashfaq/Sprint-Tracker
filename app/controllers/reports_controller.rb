class ReportsController < ApplicationController
  before_action :load_data
  def index
    respond_to do |format|
      format.html
    end
  end

  def sprint_report
    unless params[:sprint_id].nil?
      @sprint = @sprints.find(params[:sprint_id])
      @sprint_report_attributes = @sprint.issues.left_outer_joins(:time_logs).group('issues.assignee_id').select("issues.*, sum(time_logs.logged_time) as total_time_spent, count(*) AS total_issues, count('Open') as open_issues, count('Resolved') as resolved_issues, sum(estimated_time) as total_estimated_time")
    end
    respond_to do |format|
      format.html
      format.js
      headers = %w[assignee_name total_issues open_issues resolved_issues total_estimated_time total_time_spent]
      format.csv { send_data ReportCsv.new(headers, @sprint_report_attributes).to_csv, :type => 'text/csv;', filename: "sprint_report-#{Date.today}.csv" }
    end
  end

  def issue_report
    unless params[:sprint_id].nil?
      @sprint = @sprints.find(params[:sprint_id])
      @issue_report_attributes = @sprint.issues.order("assignee_id DESC").select("issues.*").paginate(page: params[:page])
    end
    respond_to do |format|
      format.html
      format.js
      headers = %w[status title assignee_name priority category estimated_time total_time_spent]
      format.csv { send_data ReportCsv.new(headers, @issue_report_attributes).to_csv, type: 'text/csv;', filename: "issues_report-#{Date.today}.csv" }
    end
  end

  def load_data
    #@projects = Project.accessible_by(current_ability)
    @issues = Issue.accessible_by(current_ability)
    @sprints = Sprint.accessible_by(current_ability)
    @users = User.accessible_by(current_ability)
  end

  def reports_param
    params.require(:issue).permit(:sprint_id)
  end
end