# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  #before_action :configure_sign_in_params, only: [:create]
  #before_action :configure_sign_up_params, only: [:create]
  #before_filter :configure_account_update_params, only: [:update]
  #skip_before_action :allow_params_authentication!, only: [:create]
  # GET /resource/sign_in

  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name,:login, :username, :email, :password, :password_confirmation) }
  # end

  # If you have extra params to permit, append them to the sanitizer.
#   def configure_account_update_params
#     devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:login, :username, :email, :password, :password_confirmation, :current_password) }
#   end
  

  def create
    binding.pry
    u = User.unscoped.includes(:company).where(email: params[:user][:email])
    if u.length.positive? && request.subdomain == ""
      redirect_to list_companies_path
    end
    super
    # if member.present?
    #   if !member.active
    #     flash[:danger] = t('.inactive_employee')
    #   elsif member.confirmation_token.present?
    #     flash[:danger] = t('.confirm_email')
    #     return redirect_to new_session_path
    #   elsif !member.valid_password?(params[:employee][:password])
    #     flash[:danger] = t('.invalid_pswd_email_notice')
    #     return redirect_to new_session_path
    #   end
    # else
    #   flash[:danger] = t('.invalid_pswd_email_notice')
    #   return redirect_to new_session_path
    # end
    # if Company.current_company.subdomain == Company.employee.company.subdomain
    #   clean_up_passwords(member)
    #   sign_in(resource_name, member)
    #   yield member if block_given?
    #   if flash[:alert].blank?
    #     flash[:notice] = t('.success_notice')
    #   end
    #   respond_with member, location: members_path
    # else
    #   flash[:danger] = t('.not_belongs_to_company', current_company_name: current_company.name)
    #   redirect_to new_session_path
    # end
  end

#   # DELETE /resource/sign_out
#   def destroy
#     # puts super.name
#     super
#   end


#   # protected

#   # If you have extra params to permit, append them to the sanitizer.
#   def configure_sign_in_params
#     devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
#   end
end