class TopicNotification < ActiveRecord::Base
  belongs_to :topic
  belongs_to :notification
end
