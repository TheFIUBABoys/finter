class TopicsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_topics      = current_user.topics
    @suggested_topics = Topic.all - @user_topics
  end

  def show
    @topic         = Topic.find(params.fetch(:id))
    @notifications = @topic.notifications
    @tweets        = topic_service.call
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

  def topic_service
    @topic_service ||= PopulateTopicNotifications.new(@topic)
  end
end
