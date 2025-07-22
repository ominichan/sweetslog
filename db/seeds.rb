# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Category.create!([
  { name: "ケーキ" },
  { name: "焼き菓子" },
  { name: "チョコレート" },
  { name: "プリン・ゼリー・ムース" },
  { name: "パン" },
  { name: "和スイーツ" },
  { name: "冷たいスイーツ" },
  { name: "温かいスイーツ" },
  { name: "ドリンクスイーツ" },
  { name: "グラススイーツ" },
  { name: "季節限定" }
])
