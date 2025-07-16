class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [ :show, :my_posts, :edit, :update, :authentication ]
  def show
  end

  def my_posts
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

  def profile
    @user = User.find(params[:id])
    @pagy, @posts = pagy(@user.posts.includes(:user).order(created_at: :desc), items: 12)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to profile_user_path
    else
      render :edit
    end
  end

  def authentication
    if @user.provider.present?
      redirect_to user_path(@user), alert: "Googleでログインしているため、個人情報の変更はできません。"
    end
  end

  def confirm
    user = current_user
    if user.email == params[:email] && user.valid_password?(params[:password])
      UserMailer.send_edit_profile(user).deliver_now
      redirect_to authentication_sent_mail_path, notice: "メールを送信しました。"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが間違っています。"
      render :authentication, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :image)
  end

  def set_user
    @user = current_user
  end
end
