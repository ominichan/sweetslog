class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def my_posts
    @user = User.find(params[:id])
    @q = @user.posts.ransack(params[:q])
    @pagy, @posts = pagy(@q.result(distinct: true).order(created_at: :desc), limit: 12)

    if params[:date].present?
      date = Date.parse(params[:date]) rescue nil
      if date
        @posts = @user.posts.where(created_at: date.beginning_of_day..date.end_of_day).order(created_at: :asc)
      end
    end
    @pagy, @calendar_posts = pagy(@q.result(distinct: true).order(created_at: :desc), limit: 12)
  end
end
