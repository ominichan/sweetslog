class StaticPagesController < ApplicationController
  def top
    @posts = Post.order(created_at: :asc).limit(6)
  end
end
