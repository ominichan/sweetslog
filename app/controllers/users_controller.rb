class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = current_user
  end

  def my_posts
    @user = current_user
    @q = @user.posts.ransack(params[:q])

    if params[:date].present?
      begin
        date = Date.parse(params[:date])
        scoped_posts = @user.posts.where(created_at: date.beginning_of_day..date.end_of_day)
      rescue ArgumentError
        scoped_posts = @q.result(distinct: true)
      end
    else
      scoped_posts = @q.result(distinct: true)
    end

    @pagy, @posts = pagy(scoped_posts.order(created_at: :desc), items: 12)
    @calendar_posts = @q.result(distinct: true)
  end
end
