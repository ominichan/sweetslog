class Category < ApplicationRecord
  has_many :post_categories, dependent: :destroy
  has_many :posts, through: :post_categories

  def self.ransackable_attributes(auth_object = nil)
    %w[id name]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[post_categories posts]
  end
end
