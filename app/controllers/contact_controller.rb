class ContactController < ApplicationController
  def new
  end

  def create
    ContactJob.perform_later params.permit(:message)[:message]
  end
end
