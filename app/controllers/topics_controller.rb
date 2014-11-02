class TopicsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_topics      = current_user.topics
    @suggested_topics = Topic.all - @user_topics
  end

  def show
    @topic         = Topic.find(params.fetch(:id))
    @notifications = @topic.notifications
    @tweets        = topic_tweets(@topic)
  end

  def new
  end

  def create
    Topic.create(topic_params)
    redirect_to topics_path
  end

  def update
    Topic.find(params.fetch(:id)).update(topic_params)
    redirect_to topics_path
  end

  def edit
    @topic = Topic.find(params.fetch(:id))
  end

  def follow
    current_user.topics << topic_from_params
    redirect_to topics_path
  end

  def unfollow
    current_user.topics.delete(topic_from_params)
    redirect_to topics_path
  end

  private

  def topic_from_params
    Topic.find(params.fetch(:id) || topic_params.fetch(:id))
  end

  def topic_params
    params.fetch(:topics).
      permit(:id, :name, :description, :twitter_keywords, :promoted)
  end

  def topic_tweets(topic)
    return topic.notifications if topic.notifications.count > 0 && topic.notifications.first.created_at > 1.hour.ago
    by_keyword = topic.twitter_keywords.split(' ').map do |keyword|
      twitter_client.search(keyword, result_type: 'recent').take(3)
    end
    notifications = by_keyword.flatten.map do |tweet|
      Notification.create(twitter_handle: tweet.user.name, body: tweet.full_text.encode('UTF-8', 'ISO-8859-1'), url: tweet.url.to_s, promoted: false)
    end
    TopicNotification.where(topic: topic).delete_all
    topic.notifications = notifications
    topic.save
    notifications
  end
end
