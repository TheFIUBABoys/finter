class Notification < ActiveRecord::Base
  has_many :topic_notifications
  has_many :topics, through: :topic_notifications

  def self.create_from_tweet(tweet, promoted = false)
    Notification.create(
      twitter_handle: tweet.user.name,
      body: tweet.full_text.encode('UTF-8', 'ISO-8859-1'),
      url: tweet.url.to_s,
      promoted: promoted
    )
  end

  def score(keyword)
    body.count(keyword).to_f / keyword.size
  end
end
