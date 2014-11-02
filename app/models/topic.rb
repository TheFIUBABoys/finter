class Topic < ActiveRecord::Base
  has_many :topic_notifications, dependent: :destroy
  has_many :notifications, through: :topic_notifications

  has_many :user_topics, dependent: :destroy
  has_many :users, through: :user_topics

  validates_uniqueness_of :name
end
