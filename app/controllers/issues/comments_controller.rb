class Issues::CommentsController < CommentsController
  before_action :set_commentable

  private
  def set_commentable
    binding.pry
    @commentable = Issue.find_by(id: params[:issue_id])
  end
end