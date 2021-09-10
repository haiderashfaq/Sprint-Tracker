class IssuesController < ApplicationController

  load_and_authorize_resource :project, find_by: :sequence_num, through: :current_company, if: -> { params[:project_id].present? }
  load_and_authorize_resource :issue, find_by: :sequence_num, through: :project, if: -> { params[:project_id].present? }
  load_and_authorize_resource :issue, find_by: :sequence_num, through: :current_company, if: -> { params[:project_id].blank? }
  before_action :set_creator, only: :create
  before_action :filter_issues, only: :index
  before_action :fetch_projects, only: [:new, :edit]

  # GET /issues
  def index
    @issues = @issues.includes(:creator, :reviewer).paginate(page: params[:page])
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
        format.html { redirect_to issue_path(id: @issue.sequence_num), notice: t('shared.success.create', resource_label: t('issues.issue_label'))  }
        format.js

      else
        flash.now[:error] = @issue.errors.full_messages
        format.js
      end
    end
  end

  # PUT /issues/:sequence_num/edit
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to issue, notice: t('shared.success.create', resource_label: t('issues.issue_label'))  }
        format.js

      else
        flash.now[:error] = @issue.errors.full_messages
        format.js
      end
    end
  end

  # DELETE /issues/:sequence_num
  def destroy
    respond_to do |format|
      if @issue.destroy
        format.js { flash.now[:notice] = t('shared.success.delete', resource_label: t('sprints.label')) }
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
    params.require(:issue).permit(:title, :description, :status, :category, :priority, :estimated_end_date,
              :estimated_start_date, :actual_start_date, :actual_end_date, :project_id, :reviewer_id, :assignee_id)
  end

  def set_creator
    @issue.creator = current_user
  end

  def filter_issues
    @issues = @issues.where(project_id: params[:project_id]) unless params[:project_id].nil?
  end

  def fetch_projects
    binding.pry
    @projects = @current_company.projects
    @users = @current_company.users
  end

  def set_project
    issue.project_id = params[:project_id]
  end
end
