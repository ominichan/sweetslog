class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 65_535 }

  has_one_attached :image

  belongs_to :user
  has_many :likes, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    %w[title body]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
