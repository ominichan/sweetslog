class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 65_535 }

  has_many_attached :images

  belongs_to :user
end
