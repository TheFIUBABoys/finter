class PopulateTopicNotifications
  attr_reader :topic

  def initialize(topic)
    @topic = topic
  end

  def call
    return Response.new(topic.notifications) if outdated_notifications(topic.notifications)

    by_keyword = topic.twitter_keywords.split(' ').map do |keyword|
      twitter_client.search(keyword, result_type: 'popular').take(3)
    end
    notifications = by_keyword.flatten.uniq { |t| t.id }.map do |tweet|
      Notification.create(twitter_handle: tweet.user.name, body: tweet.full_text.encode('UTF-8', 'ISO-8859-1'), url: tweet.url.to_s, promoted: false)
    end
    topic.notifications.destroy_all
    topic.notifications = notifications
    topic.save

    Response.new(notifications)
  end

  private

  def outdated_notifications(notifications)
    notifications.count > 0 && notifications.first.created_at > 1.hour.ago
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
