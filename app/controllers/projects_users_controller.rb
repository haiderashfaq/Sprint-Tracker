class ProjectsUsersController < ApplicationController
  load_and_authorize_resource :project, find_by: :sequence_num
  load_and_authorize_resource :projects_user, through: :project, except: :create
  authorize_resource only: :create

  # POST /projects/:sequence_num/projects_users
  def index
    @projects_users = @projects_users.paginate(page: params[:page])
    respond_to do |format|
      format.js
    end
  end

  # POST /projects/:sequence_num/projects_user/new
  def new
    @users = @current_company.users.joins("LEFT JOIN projects_users ON users.id = projects_users.user_id and projects_users.project_id = #{@project.id}").where(projects_users: { id: nil })
    respond_to do |format|
      format.js
    end
  end

  # POST /projects/:sequence_num/projects_users
  def create
    user_ids = projects_user_params[:user_id].reject(&:blank?)
    users = User.find(user_ids)
    binding.pry

    users.each do |user|
      @project.projects_users.build(user: user)
    end

    respond_to do |format|
      binding.pry
      if @project.save
        @projects_users = @project.projects_users.where(user_id: user_ids)
        format.js { flash.now[:notice] = t('shared.success.add', resource_label: t('users.label').pluralize) }
      else
        format.js { flash.now[:error] = @project.errors.full_messages }
      end
    end
  end

  # DELETE /projects/:sequence_num/projects_user/:user_id/delete
  def destroy
    @projects_user = @project.projects_users.find_by(id: params[:id])
    respond_to do |format|
      if @projects_user.destroy
        format.js { flash.now[:notice] = t('shared.success.delete', resource_label: t('users.label')) }
      else
        format.js { flash.now[:error] = @projects_user.errors.full_messages }
      end
    end
  end

  # private

  def projects_user_params
    params.require(:projects_user).permit(user_id: [])
  end
end
