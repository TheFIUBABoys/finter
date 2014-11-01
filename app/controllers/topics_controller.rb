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
    topic = Topic.find(params.fetch(:id))
    current_user.topics << topic
    redirect_to topics_path
  end
end
