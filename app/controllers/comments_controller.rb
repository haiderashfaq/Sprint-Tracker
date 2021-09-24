class CommentsController < ApplicationController
  def new
    respond_to do |format|
      format.js
    end
  end

  def create
    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      format.js
    end
  end

  def index
    respond_to do |format|
      format.js
    end
  end

  def destroy
    respond_to do |format|
      format.js
    end
  end

  def show
    respond_to do |format|
      format.js
    end
  end

  def comment_params
    params.require(:comment).permit(:description, :commentable_id, :commentable_type)
  end
end
