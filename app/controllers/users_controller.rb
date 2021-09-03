class UsersController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num, through: :current_company
  binding.pry
  def index
    respond_to do |format|
    format.html
    format.json { render json: UserDatatable.new(params) }
    end
  end

  def show
  end

  def new
  end

  def create
    binding.pry
    if @user.save
      redirect_to users_path
    else
      render new_user_url
    end
  end

  def edit
    @user = User.unscoped.find(params[:id])
  end

  def update
    binding.pry
    if @user.update(user_params)
      redirect_to users_url
    else
      render :edit
    end
  end

  def destroy
    binding.pry
    @user.destroy

    redirect_to users_url
  end
end

private

def user_params
  params.require(:user).permit(:name,
      :email,
      :password,
      :phone_num,
      :role_id,
      company_attributes: [:name, :subdomain]) 
end
