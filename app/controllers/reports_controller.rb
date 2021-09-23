class ReportsController < ApplicationController
  authorize_resource 
  before_action :load_data
  def index
    respond_to do |format|
      format.html
    end
  end

  def sprint
    if params[:sprint_id].present?
      @sprint = fetch_sprint
      @sprint_report_attributes = Report.sprint_report_data(@sprint)&.paginate(page: params[:page])
    end
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data ReportCsv.new(Report::SPRINT_HEADERS, @sprint_report_attributes).to_csv, type: 'text/csv;', filename: report_filename('sprint') }
    end
  end

  def issues
    if params[:sprint_id].present?
      @sprint = fetch_sprint
      @issue_report_attributes = Report.issues_report_data(@sprint)&.paginate(page: params[:page])
    end
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data ReportCsv.new(Report::ISSUE_HEADERS, @issue_report_attributes).to_csv, type: 'text/csv;', filename: report_filename('issues') }
    end
  end

  def load_data
    @issues = Issue.accessible_by(current_ability)
    @sprints = Sprint.accessible_by(current_ability)
    @users = User.accessible_by(current_ability)
  end

  private
  def report_filename(attribute)
    "#{attribute}_report_#{current_user.id}_#{current_company.subdomain}-#{Date.today}.csv"
  end

  def fetch_sprint
    @sprints.find_by(id: params[:sprint_id])
  end
end
