class ProjectsUsersController < ApplicationController
  # POST /projects/:sequence_num/projects_users
  def index
    @project = Project.find_by(sequence_num: params[:project_id])
    @projects_users = @project.projects_users
    respond_to do |format|
      # format.html
      format.js
    end
  end

  # POST /projects/:sequence_num/projects_user/new
  def new
    @project = Project.find_by(sequence_num: params[:project_id])
    @users = @current_company.users
    @projects_user = ProjectsUser.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /projects/:sequence_num/projects_user
  def create
    @project = Project.find_by(sequence_num: params[:project_id])
    user_ids = projects_user_params[:user_id].reject(&:blank?)
    users = User.find(user_ids)

    projects_users = users.map { |user| { user: user } }

    binding.pry

    ProjectsUser.transaction do
      @projects_users = @project.projects_users.create(projects_users)
    end

    respond_to do |format|
      if @projects_users.save
        # format.html { redirect_to project_projects_users_url, notice: t('shared.success.create', resource_label: t('projects.project_label')) }
        format.js
      else
        # format.html { render :new, alert: t('shared.failure.create', resource_label: t('projects.project_label')) }
        format.js
      end
    end
  end

  # DELETE /projects/:sequence_num/projects_user/:user_id/delete
  def destroy
    @project = Project.find_by(sequence_num: params[:project_id])
    @projects_user = @project.projects_users.find_by(id: params[:id])
    respond_to do |format|
      if @projects_user.destroy
        # format.html { redirect_to project_projects_users_url, alert: t('shared.success.delete', resource_label: t('users.label')) }
        format.js
      else
        format.js
        # format.html { render :show, alert: t('shared.failure.delete', resource_label: t('user.label')) }
      end
    end
  end

  # private

  def projects_user_params
    params.require(:projects_user).permit(user_id:[])
  end
end
