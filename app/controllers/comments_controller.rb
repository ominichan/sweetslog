class CommentsController < ApplicationController
before_action :authenticate_user!
  def create
    @comment = current_user.comments.build(comment_params)
    @post = @comment.post
    @comment.user_id = current_user.id
    if @comment.save
      @comment.create_notification_comment!(current_user, @post.user_id)
      redirect_to @post
    else
      render "posts/show"
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
  end
end
