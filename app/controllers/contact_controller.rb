class ContactController < ApplicationController
  def new; end

  def create
    ContactJob.perform_later contact_params
  end

  def contact_params
    params.permit(:message)[:message]
  end
end
