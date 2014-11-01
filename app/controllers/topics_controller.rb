class TopicsController < ApplicationController
  def index
    @user_topics      = current_user.topics
    @suggested_topics = Topic.all - @user_topics
  end

  def show
    @topic         = Topic.find(params.fetch(:id))
    @notifications = @topic.notifications
  end

  def follow
    current_user.topics << topic_param
    redirect_to topics_path
  end

  def unfollow
    current_user.topics.delete(topic_param)
    redirect_to topics_path
  end

  private

  def topic_param
    Topic.find(params.fetch(:id))
  end
end
