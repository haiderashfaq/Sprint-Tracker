class ProjectsController < ApplicationController
  before_action :set_project, only: %i[edit show update destroy]
  load_and_authorize_resource

  def index
    @projects = Project.accessible_by(current_ability).paginate(page: params[:page])
  end

  def new
    @users = User.all
  end

  def create
    @project = Project.new(project_params)
    if @project.save!
      redirect_to @project, notice: t('projects.success.create')
    else
      render :new, alert: t('projects.failure.create')
    end
  end

  def edit
    @users = User.all
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: t('projects.success.update')
    else
      render :edit, alert: t('projects.failure.update')
    end
  end

  def show
    @user = User.find_by!(id: @project.manager_id)
  end

  def destroy
    @project.destroy

    redirect_to projects_url, alert: t('projects.success.delete')
  end

  private

  def set_project
    @company = Company.current_company
    @project = @company.projects.find_by_sequence_num!(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :start_date, :end_date, :manager_id)
  end
end
