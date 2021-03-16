class NotificationsController < ApplicationController
  def index
    @notifications = User.find(current_user.id).passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end
