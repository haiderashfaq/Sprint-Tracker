# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    binding.pry
    stored_subdomain = nil
    begin
      Company.transaction do
        build_resource(user_params_filter) # will be the similar to user = User.new(sign_up_params)
        resource.company.owner = resource # resource will be an instance of User
        resource.role_id = User::ROLE[:admin]
        resource.save!
        stored_subdomain = resource.company.subdomain
      end
    rescue ActiveRecord::RecordInvalid => e
      redirect_to new_user_registration_url and return
      puts e
    end
    redirect_to new_user_session_url(subdomain: stored_subdomain)
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def user_params_filter
    params.require(:user).permit(:name,
      :email,
      :password,
      :phone_num,
      company_attributes: [:name, :subdomain])
  end
end
