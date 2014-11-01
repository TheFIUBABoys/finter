class Notification < ActiveRecord::Base
  has_many :topic_notifications
  has_many :topics, through: :topic_notifications
end
