class Topic < ActiveRecord::Base
  has_many :topic_notifications
  has_many :notifications, through: :topic_notifications

  has_many :user_topics
  has_many :users, through: :user_topics

  validates_uniqueness_of :name
end
