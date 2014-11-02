class Notification < ActiveRecord::Base
  has_many :topic_notifications, dependent: :destroy
  has_many :topics, through: :topic_notifications

  validates_presence_of :twitter_handle
  validates_presence_of :body
  validates_presence_of :original_date

  scope :promoted,     -> { where(promoted: true) }
  scope :not_promoted, -> { where(promoted: false) }

  def self.new_from_tweet(tweet, promoted = false)
    Notification.new(
      twitter_handle: tweet.user.name,
      body: tweet.full_text,
      url: tweet.url.to_s,
      original_date: tweet.created_at,
      promoted: promoted
    )
  end

  def score(keyword)
    body.count(keyword).to_f / keyword.size
  end
end
