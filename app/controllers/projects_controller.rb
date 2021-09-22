class ProjectsController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num, through: :current_company
  load_resource :issues, find_by: :sequence_num, through: :project


  # GET /projectsr
  def index
    add_breadcrumbs
    @projects = @projects.includes(:issues).paginate(page: params[:page])
    respond_to do |format|
      format.html
    end
  end

  # GET /projects/new
  def new
    add_breadcrumbs
    respond_to do |format|
      format.html
    end
  end

  # POST /projects/
  def create
    @project.creator = current_user
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: t('shared.success.create', resource_label: t('projects.project_label')) }
      else
        format.html do
          flash.now[:error] = @project.errors.full_messages
          render :new
        end
      end
    end
  end

  # GET /projects/:sequence_num/edit
  def edit
    add_breadcrumbs
    respond_to do |format|
      format.html
    end
  end

  # POST /projects/:sequence_num/edit
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: t('shared.success.update', resource_label: t('projects.project_label')) }
      else
        format.html do
          flash.now[:error] = @project.errors.full_messages
          render :edit
        end
      end
    end
  end

  # GET /projects/:sequence_num
  def show
    add_breadcrumbs
    respond_to do |format|
      format.js
      format.html
    end
  end

  # DELETE /projects/:sequence_num
  def destroy
    respond_to do |format|
      if @project.destroy
        format.html { redirect_to projects_url, alert: t('shared.success.delete', resource_label: t('projects.project_label')) }
      else
        format.html do
          flash.now[:error] = @project.errors.full_messages
          render :show
        end
      end
    end
  end

  # GET /projects/:sequence_num/backlog
  def backlog
    @sprints = @project.pending_sprints
    @issues = @project.backlog_issues
    respond_to do |format|
      format.js
    end
  end

  # GET /projects/:sequence_num/active_sprint
  def active_sprint
    @active_sprint = @project.active_sprint
    unless @active_sprint.nil?
      @issues_to_do, @issues_in_progress, @issues_resolved, @issues_closed = @active_sprint.categorized_issues
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :start_date, :end_date, :manager_id)
  end

  def add_breadcrumbs
    path = request.url.split('/')
    path.drop(3).each do |route|
      if route.to_i.zero?
        if route != 'new' and route != 'edit'
          add_breadcrumb route.titleize, :"#{route}_path"
        else
          add_breadcrumb route.titleize, :"#{route}_project_path"
        end
      else
        add_breadcrumb @project.name, :project_path
      end
    end
  end

end
