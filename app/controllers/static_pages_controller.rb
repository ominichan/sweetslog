class StaticPagesController < ApplicationController
  def top
    @posts = Post.order(created_at: :asc).limit(6)
  end

  def privacy_policy
  end

  def terms_of_service
  end
end
