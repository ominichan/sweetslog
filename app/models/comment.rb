class Comment < ApplicationRecord
  validates :body, presence: true, length: { maximum: 65_535 }

  belongs_to :user
  belongs_to :post
  has_many :notifications, dependent: :destroy

  def create_notification_comment!(current_user,comment_id)
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def create_notification_comment!(current_user, visited_id)
    notification = current_user.active_notifications.new(
      post_id: post_id,
      comment_id: id,
      visited_id: visited_id,
      visitor_id: current_user.id,
      action: 'comment'
    )
    notification.save if notification.visitor_id != notification.visited_id
  end
end
