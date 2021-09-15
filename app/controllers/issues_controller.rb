class IssuesController < ApplicationController

  load_and_authorize_resource :project, find_by: :sequence_num, through: :current_company, if: -> { params[:project_id].present? }
  load_and_authorize_resource :issue, find_by: :sequence_num, through: :project, if: -> { params[:project_id].present? }
  load_and_authorize_resource :issue, find_by: :sequence_num, through: :current_company, if: -> { params[:project_id].blank? }
  before_action :set_creator, only: :create
  before_action :fetch_required_data, only: [:new, :edit, :index]

  # GET /issues
  def index
    @issues = @issues.includes(:creator, :reviewer, :project, :assignee).paginate(page: params[:page])
    @issues = FilteringParams.new(@issues, params).filter_params
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /issues/:sequence_num
  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /issues/new
  def new
    respond_to do |format|
      format.js
    end
  end

  # GET issues/:sequence_num/edit
  def edit
    respond_to do |format|
      format.js
      format.html
    end
  end

  # POST /issues/
  def create
    respond_to do |format|
      if @issue.save
        flash.now[:notice] = t('shared.success.create', resource_label: t('issues.issue_label'))
      else
        flash.now[:error] = @issue.errors.full_messages
      end
      format.js
    end
  end

  # PUT /issues/:sequence_num/edit
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        flash.now[:notice] = t('shared.success.update', resource_label: t('issues.issue_label'))
      else
        flash.now[:error] = @issue.errors.full_messages
      end
      format.js
    end
  end

  # DELETE /issues/:sequence_num
  def destroy
    respond_to do |format|
      if @issue.destroy
        format.js { flash.now[:notice] = t('shared.success.delete', resource_label: t('issues.issue_label')) }
        format.html { redirect_to issues_url }
      else
        flash.now[:error] = t('shared.failure.delete', resource_label: t('issues.issue_label'))
        format.js
        format.html { render :show }
      end
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def issue_params
    params.require(:issue).permit(:title, :description, :status, :category, :estimated_time, :priority, :estimated_end_date,
                                  :estimated_start_date, :actual_start_date, :actual_end_date, :reviewer_id, :creator_id, :assignee_id, :project_id)
  end

  def set_creator
    @issue.creator = current_user
  end

  def fetch_required_data
    @projects = @current_company.projects
    @users = @current_company.users
  end
end
