class RecommendController < ApplicationController
  before_action :set_recommend_posts

  def index; end

private

  def set_recommend_posts  
    @recommend_posts = recommend_posts
  end

  def similar_users
    liked_post_ids = current_user.likes_posts.pluck(:post_id)
    similar_user_ids = Like.where(post_id: liked_post_ids)
                               .where.not(user_id: current_user.id)
                               .distinct.pluck(:user_id)
    User.where(id: similar_user_ids)
  end

  def recommend_posts
    liked_post_ids = current_user.likes_posts.pluck(:post_id)
    similar_users = similar_users
    similar_user_post_ids = Like.where(user_id: similar_users.ids)
                                        .where.not(post_id: liked_post_ids)
                                        .distinct.pluck(:post_id)
    recommended_post_ids = Post.where(id: similar_user_post_ids)
                                        .where.not(id: liked_post_ids)
                                                              .pluck(:id)
    Post.where(id: recommended_post_ids).sample(4)
  end
end
