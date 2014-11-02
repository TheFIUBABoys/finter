class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def create
    topic = Topic.find(params.fetch(:topic_id))
    topic.notifications << Notification.create(notification_params.merge(original_date: Time.zone.now))
    redirect_to topic_path(topic)
  end

  private

  def notification_params
    params.fetch(:notification).
      permit(:twitter_handle, :body, :url, :url_label, :promoted)
  end
end
