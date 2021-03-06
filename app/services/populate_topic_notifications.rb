class PopulateTopicNotifications
  attr_reader :topic

  def initialize(topic)
    @topic = topic
  end

  def call
    return Response.new(topic.notifications) unless outdated_notifications(topic.notifications)

    notifications = tweets_by_keyword(topic.notification_type).map { |tweet| Notification.new_from_tweet(tweet) }
    notifications = notifications.sort { |a, b| ScoreNotification.new(a, topic.keywords).call <=> ScoreNotification.new(b, topic.keywords).call }
    notifications = notifications.take(20).each { |notification| notification.save }

    clear_old_promoted
    topic.notifications.where(promoted: false).destroy_all
    topic.notifications << notifications
    topic.save

    Response.new(notifications)
  end

  private

  def outdated_notifications(notifications)
    notifications.count == 0 || notifications.last.created_at < 15.minutes.ago
  end

  def clear_old_promoted
    topic.notifications.where(promoted: true, created_at: 1.month.ago..1.day.ago).destroy_all
  end

  def tweets_by_keyword(type = nil)
    topic.keywords.
      map { |keyword| get_tweets_for(keyword, type) }.
      flatten.
      uniq { |tweet| tweet.id }
  end

  def get_tweets_for(keyword, type = 'popular')
    twitter_client.search(keyword, result_type: type, count: 10).take(10)
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
