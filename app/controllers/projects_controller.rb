class ProjectsController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num

  # GET /projects
  def index
    @projects = @projects.paginate(page: params[:page])
    respond_to do |format|
      format.html
    end
  end

  # GET /projects/new
  def new
    @users = @current_company.users.all
    respond_to do |format|
      format.html
    end
  end

  # POST /projects/
  def create
    @project.owner_id = @current_company.user_id
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: t('shared.success.create', resource_label: t('projects.project_label')) }
      else
        format.html { render :new, alert: t('shared.failure.create', resource_label: t('projects.project_label')) }
      end
    end
  end

  # GET /projects/:sequence_num/edit
  def edit
    @users = @current_company.users.all
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
        format.html { render :edit, alert: t('shared.failure.update', resource_label: t('projects.project_label')) }
      end
    end
  end

  # GET /projects/:sequence_num
  def show
    respond_to do |format|
      format.html
    end
  end

  # DELETE /projects/:sequence_num
  def destroy
    respond_to do |format|
      if @project.destroy
        format.html { redirect_to projects_url, alert: t('shared.success.delete', resource_label: t('projects.project_label')) }
      else
        format.html { render :show, alert: t('shared.failure.delete', resource_label: t('projects.project_label')) }
      end
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :start_date, :end_date, :manager_id)
  end
end
