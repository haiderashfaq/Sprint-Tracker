# app/controllers/errors_controller.rb

class ErrorsController < ApplicationController

  def not_found
    render status: 404, layout: false
  end

  def internal_server
    render status: 500, layout: false
  end

  def unprocessable
    render status: 422, layout: false
  end

  def unacceptable
    render status: 406, layout: false
  end

  def access_denied
    render status: 401, layout: false
  end
end