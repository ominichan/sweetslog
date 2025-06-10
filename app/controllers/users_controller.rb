class UsersController < ApplicationController

  def show
    @user = current_user
  end

  def my_posts
    @user = User.find(params[:id])
    @q = @user.posts.ransack(params[:q])
    @pagy, @posts = pagy(@q.result(distinct: true).order(created_at: :desc), limit: 12)
  end
end
