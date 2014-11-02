class TopicNotification < ActiveRecord::Base
  belongs_to :topic, dependent: :destroy
  belongs_to :notification, dependent: :destroy
end
