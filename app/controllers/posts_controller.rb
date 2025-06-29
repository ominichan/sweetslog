class PostsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy, :likes, :tags ]
  def index
    @q = Post.ransack(params[:q])
    if params[:tag_name]
      @pagy, @posts = pagy(Post.joins(:tags).where(tags: { name: params[:tag_name] }).includes(:user).order(created_at: :desc), limit: 12)
    else
      @pagy, @posts = pagy(@q.result(distinct: true).includes(:user).order(created_at: :desc), limit: 12)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "ポストが作成されました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    @post.image.attach(params[:post][:image]) if @post.image.blank?
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "ポストが更新されました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    redirect_to posts_path, notice: "ポストが削除されました"
  end

  def likes
    @q = current_user.like_posts.ransack(params[:q])
    @pagy, @like_posts = pagy(@q.result(distinct: true).includes(:user).order(created_at: :desc), limit: 12)
  end

  def tags
    @tag = Tag.new
  end


  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :tag_names, :spot, :address, :latitude, :longitude)
  end
end
