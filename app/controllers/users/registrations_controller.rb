# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  # GET /resource/sign_up
  # def new
  #   if !params[:subdomain1].nil?
  #     redirect_to new_user_session_url(subdomain: params[:subdomain1])
  #   else
  #     super
  #   end
  # end

  # POST /resource
  def create
    stored_subdomain = nil
    begin
      Company.transaction do
        build_resource(user_params_filter) # will be the similar to user = User.new(sign_up_params)
        resource.company.owner = resource # resource will be an instance of User
        resource.role_id = User::ROLE_ID[:admin]
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

  # PUT /resource

  # DELETE /resource

  # GET /resource/cancel

  def user_params_filter
    params.require(:user).permit(:name,
      :email,
      :password,
      :phone_num,
      company_attributes: [:name, :subdomain])
  end
end
