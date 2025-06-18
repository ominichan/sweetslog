class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 65_535 }
  validates :address, presence: true
  validates :spot, presence: true

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  geocoded_by :address
  after_validation :geocode

  has_one_attached :image

  belongs_to :user
  has_many :likes, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    %w[title body created_at]
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
end
