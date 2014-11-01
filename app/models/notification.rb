class Notification < ActiveRecord::Base
  belongs_to :topic

  validates_presence_of :topic
end
