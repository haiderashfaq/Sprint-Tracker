class CommentsController < ApplicationController

  load_and_authorize_resource :comment, through: :current_company
  def create
    @comment = @commentable.comments.new(comment_params)
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
    @comment = Comment.find_by(id: params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        flash.now[:notice] = t('shared.success.update', resource_label: t('comments.label'))
      else
        flash.now[:error] = @comment.errors.full_messages
      end
      format.js
    end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        flash.now[:notice] = t('shared.success.delete', resource_label: t('comments.label'))
      else
        flash.now[:error] = @comment.errors.full_messages
      end
      format.js
    end
  end

  def index
    @comments = @commentable.comments
    respond_to do |format|
      format.js
    end
  end

  private
  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:description)
  end
end