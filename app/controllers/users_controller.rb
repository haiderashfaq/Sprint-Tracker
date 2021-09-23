class UsersController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num, through: :current_company

  def index
    @users = @users.paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(params) }
    end
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

  def create
    @user.new_member = true
    respond_to do |format|
      if @user.save

        format.html { redirect_to @user, notice: t('shared.success.create', resource_label: t('users.label')) }
      else
        format.html { render :new, alert: t('shared.failure.create', resource_label: t('users.label')) }
      end
    end
  end

  def edit
    respond_to do |format|
      format.html
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: t('shared.success.update', resource_label: t('users.label')) }
      else
        flash.now[:alert] = t('shared.failure.update', resource_label: t('users.label'))
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to users_url, alert: t('shared.success.delete', resource_label: t('users.label')) }
      else
        flash.now[:alert] = t('shared.failure.delete', resource_label: t('users.label'))
        flash.now[:error] = @user.errors.full_messages
        format.html { render :show }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :phone_num,
      :role_id
    )
  end
end
