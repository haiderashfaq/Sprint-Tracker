class SprintsController < ApplicationController
  load_and_authorize_resource :project, find_by: :sequence_num, if: -> { params[:project_id].present? }
  load_and_authorize_resource :sprint, through: :project, find_by: :sequence_num, if: -> { params[:project_id].present? }
  load_and_authorize_resource :sprint, find_by: :sequence_num, if: -> { params[:project_id].blank? }

  # GET /projects/:sequence_num/sprints
  def index
    @sprints = @sprints.paginate(page: params[:page])
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /projects/:sequence_num/sprints/new
  def new
    @projects = Project.accessible_by(current_ability) if @project.nil?
    respond_to do |format|
      format.js
    end
  end

  # POST /projects/:sequence_num/sprints/new
  def create
    @sprint.creator = current_user
    @sprint.status = "PLANNING"
    respond_to do |format|
      if @sprint.save
        format.js { flash.now[:notice] = t('shared.success.create', resource_label: t('sprints.label')) }
      else
        format.js { flash.now[:error] = @sprint.errors.full_messages }
      end
    end
  end

  # GET /projects/:sequence_num/sprints/:sequence_num/edit
  def edit
    respond_to do |format|
      format.js
    end
  end

  # POST /projects/:sequence_num/sprints/:sequence_num/edit
  def update
    respond_to do |format|
      if @sprint.update(sprint_params)
        format.js { flash.now[:notice] = t('shared.success.update', resource_label: t('sprints.label')) }
      else
        format.js { flash.now[:error] = @sprint.errors.full_messages }
      end
    end
  end

  # GET /projects/:sequence_num/sprints/:sequence_num
  def show
    respond_to do |format|
      format.js
      format.html
    end
  end

  # DELETE /projects/:sequence_num/sprints/:sequence_num
  def destroy
    respond_to do |format|
      if @sprint.destroy
        format.js { flash.now[:notice] = t('shared.success.delete', resource_label: t('sprints.label')) }
        format.html { redirect_to sprints_url, notice: t('shared.success.delete', resource_label: t('sprints.label')) }
      else
        format.js { flash.now[:error] = t('shared.failure.delete', resource_label: t('sprints.label')) }
        format.html { render :show, error: t('shared.failure.delete', resource_label: t('sprints.label')) }
      end
    end
  end

  # GET sprints/:sequence_num/start_sprint_info
  def start_sprint_info
    respond_to do |format|
      format.js
    end
  end

  # PATCH sprints/:sequence_num/start_sprint
  def start_sprint
    respond_to do |format|
      if Sprint.activate_sprint(@sprint)
        format.js { flash.now[:notice] = t('sprints.started') }
      else
        format.js { flash.now[:error] = @sprint.errors.full_messages }
      end
    end
  end

  # GET sprints/:sequence_num/complete_sprint_info
  def complete_sprint_info
    @project, @issues_unresolved, @issues_resolved = Sprint.get_project_resolved_and_unresolved_issues(@sprint)
    respond_to do |format|
      format.js
    end
  end

  # POST sprints/:sequence_num/complete_sprint
  def complete_sprint
    @project, @issues_unresolved, @issues_resolved = Sprint.get_project_resolved_and_unresolved_issues(@sprint)
    respond_to do |format|
      if Sprint.complete_sprint(@sprint, @project, @issues_unresolved, params[:issues_dest])
        format.js
      else
        format.js { flash.now[:error] = @sprint.errors.full_messages }
      end
    end
  end

  # GET sprints/:sequence_num/report
  def report
    @issues_resolved, @issues_unresolved = Sprint.report_content(@sprint)
    respond_to do |format|
      format.html
    end
  end

  private

  def sprint_params
    params.require(:sprint).permit(:name, :description, :start_date, :end_date, :estimated_start_date, :estimated_end_date, :project_id, status: "PLANNING")
  end
end
