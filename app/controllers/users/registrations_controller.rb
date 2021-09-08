# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def create
    begin
      subdomain = Company.create_symbol!(user_params)
    rescue ActiveRecord::RecordInvalid => e
      build_resource({})
      flash.now[:error] = e.message.split(',')
      render 'new' and return
    end
    redirect_to new_user_session_url(
      subdomain: subdomain,
      email: params[:user][:email]
    )
  end

  def user_params
    params.require(:user).permit(:name,
      :email,
      :password,
      :phone_num,
      company_attributes: [:name, :subdomain])
  end
end
