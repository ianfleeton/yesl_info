class CommentsController < ApplicationController
  before_action :admin_required

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to @comment.issue
  end

  private

    def comment_params
      params.require(:comment).permit(:comment, :issue_id)
    end
end
