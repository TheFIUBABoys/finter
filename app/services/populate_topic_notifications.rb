class PopulateTopicNotifications
  attr_reader :topic

  def initialize(topic)
    @topic = topic
  end

  def call
    # return Response.new(topic.notifications) unless outdated_notifications(topic.notifications)

    notifications = tweets_by_keyword.map { |tweet| Notification.create_from_tweet(tweet) }
    notifications = notifications.sort { |a, b| ScoreNotification.new(a, topic.keywords).call <=> ScoreNotification.new(b, topic.keywords).call }
    notifications = notifications.take(20)

    topic.notifications.destroy_all
    topic.notifications = notifications
    topic.save

    Response.new(notifications)
  end

  private

  def outdated_notifications(notifications)
    notifications.count == 0 || notifications.first.created_at > 15.minutes.ago
  end

  def tweets_by_keyword
    topic.keywords.
      map { |keyword| get_tweets_for(keyword) }.
      flatten.
      uniq { |tweet| tweet.id }.
      select { |tweet| tweet.full_text.encoding.to_s == 'UTF-8' }
  end

  def get_tweets_for(keyword)
    twitter_client.search(keyword, result_type: 'popular').take(10)
  end

  def twitter_client
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = 'Uv0j5zucxjhagAqfaGKnpQzeO'
      config.consumer_secret     = 'hmNcGr33Shl87Fcs8oxStOGrRuVfQYHz5MPl3P84FIief5Fgfn'
      config.access_token        = '2821251712-T5vqdPZHwCEmsmTbJm22y8szQ8YhH5mn6DAO0tv'
      config.access_token_secret = 'H2qEXs5zJJ8vFhrKBoFxjLWbbp4FIKF4OEYhUg1yDCC6M'
    end
  end
end
