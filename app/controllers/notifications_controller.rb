class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def mark_as_read
    current_user.passive_notifications.where(checked: false).update_all(checked: true)
    head :ok
  end
end
