class IssuesController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num, through: :current_company
  before_action :set_creator, only: :create

  # GET /issues
  def index
    @issues = @issues.includes(:creator, :reviewer).paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /issues/:sequence_num
  def show
    respond_to do |format|
      format.html
    end
  end

  # GET /issues/new
  def new
    respond_to do |format|
      format.html
    end
  end

  # GET issues/:sequence_num/edit
  def edit
    respond_to do |format|
      format.html
    end
  end

  # POST /issues/
  def create
    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: t('shared.success.create', resource_label: t('issues.issue_label'))  }
      else
        flash.now[:error] = t('shared.failure.create', resource_label: t('issues.issue_label'))
        format.html { render :new }
      end
    end
  end

  # PUT /issues/:sequence_num/edit
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue, notice: t('shared.success.update', resource_label: t('issues.issue_label')) }
      else
        flash.now[:error] = t('shared.failure.update', resource_label: t('issues.issue_label'))
        format.html { render :edit }
      end
    end
  end

  # DELETE /issues/:sequence_num
  def destroy
    respond_to do |format|
      if @issue.destroy
        format.html { redirect_to issues_url, notice: t('shared.success.delete', resource_label: t('issues.issue_label')) }
      else
        flash.now[:error] = t('shared.failure.delete', resource_label: t('issues.issue_label'))
        format.html { render :show }
      end
    end
  end

  # POST issues/add_issues
  def add_issues_to_sprint
    issue_ids = params[:issue_ids].split(',')
    @issues = Issue.where(id: issue_ids)
    @sprint_id = params[:sprint_id]

    respond_to do |format|
      format.js if @issues.update(sprint_id: @sprint_id)
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def issue_params
    params.require(:issue).permit(:title, :description, :status, :category, :estimated_time, :priority, :estimated_end_date,
                                  :estimated_start_date, :actual_start_date, :actual_end_date)
  end

  def set_creator
    @issue.creator = current_user
  end
end
