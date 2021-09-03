class IssuesController < ApplicationController

  load_and_authorize_resource find_by: :sequence_num, through: :current_company
  before_action :set_creator, only: :create

  def index
    @issues = Issue.accessible_by(current_ability).paginate(page: params[:page])
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def new
    respond_to do |format|
      format.html
    end
  end

  def edit
    respond_to do |format|
      format.html
    end
  end

  def create
    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue, notice: t('shared.success.update', resource_label: t('issues.issue_label')) }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url, notice: t('shared.success.delete', resource_label: t('issues.issue_label')) }
      format.json { head :no_content }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def issue_params
    params.require(:issue).permit(:title, :description, :status, :category, :priority, :estimated_end_date,
                                  :estimated_start_date)
  end

  def set_creator
    @issue.creator = current_user
  end

end
