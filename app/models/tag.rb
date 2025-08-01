class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    [ "name" ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[post_tags posts]
  end

  def self.remove_unused
    left_outer_joins(:posts).where(posts: { id: nil }).destroy_all
  end
end
