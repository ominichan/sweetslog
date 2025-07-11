class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 65_535 }
  validates :address, presence: true
  validates :spot, presence: true

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  after_destroy :cleanup_unused_tags

  has_many :comments, dependent: :destroy

  geocoded_by :address
  after_validation :geocode

  has_one_attached :image

  belongs_to :user
  has_many :likes, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    %w[title body created_at address tags]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[post_tags tags]
  end

  def tag_names
    tags.map(&:name).join(",")
  end

  def tag_names=(names)
    self.tags = names.split(",").map do |name|
      Tag.find_or_create_by(name: name.strip)
    end
  end

  def self.recommend_posts_for(user)
    return none unless user

    liked_post_ids = user.like_posts.pluck(:post_id)

    similar_user_ids = Like.where(post_id: liked_post_ids)
                           .where.not(user_id: user.id)
                           .distinct.pluck(:user_id)
    return none if similar_user_ids.empty?

    similar_user_post_ids = Like.where(user_id: similar_user_ids)
                                .where.not(post_id: liked_post_ids)
                                .distinct.pluck(:post_id)
    return none if similar_user_post_ids.empty?

    where(id: similar_user_post_ids).where.not(user_id: user.id).limit(4)
  end

  private

  def remove_unused_tags
    tags.each do |tag|
      if tag.posts.where.not(id: self.id).empty?
        tag.destroy
      end
    end
  end

  def cleanup_unused_tags
    Tag.remove_unused
  end
end
