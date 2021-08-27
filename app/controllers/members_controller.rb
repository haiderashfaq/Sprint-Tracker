class MembersController < ApplicationController
  def index
    @users = User.all
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
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
