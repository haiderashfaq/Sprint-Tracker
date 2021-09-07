# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def create
    stored_subdomain = nil
    begin
      stored_subdomain = Company.build_user(user_params_filter)
      
    rescue ActiveRecord::RecordInvalid => e
      render new_user_registration_url and return
      flash[:alert] = e
    end
    redirect_to new_user_session_url(subdomain: stored_subdomain)
  end

  def user_params_filter
    params.require(:user).permit(:name,
      :email,
      :password,
      :phone_num,
      company_attributes: [:name, :subdomain])
  end
end
