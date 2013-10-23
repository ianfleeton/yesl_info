class CommentsController < ApplicationController
  before_action :user_required

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    authorize_same_organisation! @comment.issue

    @comment.save
    redirect_to @comment.issue
  end

  private

    def comment_params
      params.require(:comment).permit(:comment, :issue_id)
    end
end
