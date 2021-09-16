# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # def show
  # binding.pry
  # self.resource = resource_class.unscoped.find_by_confirmation_token(params[:confirmation_token]) if params[:confirmation_token].present?
  # #super if resource.nil? or resource.confirmed?

  # if resource.errors.empty?
  #   set_flash_message!(:notice, :confirmed)
  #   respond_with_navigational(resource) { redirect_to after_confirmation_path_for(resource_name, resource) }
  # else
  #   respond_with_navigational(resource.errors, status: :unprocessable_entity){ render :new }
  # end
  # end
  # def show
  #   binding.pry
  #   respond_with_navigational(resource) { redirect_to after_confirmation_path_for(resource_name, resource) }
  # end

  protected

  def after_confirmation_path_for(resource_name, resource)
     return root_url if params[:confirmation_token].blank? || (resource = resource_class.find_by_confirmation_token(params[:confirmation_token])).blank?

    # Setting reset_password_token itself to reach reset password screen for the user
    resource = resource_class.find_by(confirmation_token: params[:confirmation_token])
    token    = Devise.token_generator.generate(resource_class, :reset_password_token)
    resource.update_columns({ reset_password_token: token.second, reset_password_sent_at: Time.now.utc })
    edit_user_password_url(resource, reset_password_token: token.first)
  end
end
