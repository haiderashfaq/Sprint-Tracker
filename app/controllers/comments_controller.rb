class CommentsController < ApplicationController
  
  def create
    @comment = @commentable.comments.new
    @comment.commenter = current_user
    if @comment.save
      flash.now[:notice] = 'Comment Successfully added!'
    else
      flash.now[:error] = 'Comment not added!'
    end
    respond_to do |format|
      format.js
    end
  end

  def new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def index
    @comments = @commentable.comments
    binding.pry
    respond_to do |format|
      format.js
    end
  end

end