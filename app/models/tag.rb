class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  scope :popular, -> { where(id: Post_tag.group(:tag_id).order('count_tag_id desc').limit(5).count(:tag_id).keys) }
end
