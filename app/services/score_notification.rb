class ScoreNotification
  attr_reader :notification, :keywords

  def initialize(tweet, keywords)
    @notification = tweet
    @keywords     = keywords
  end

  def call
    score = keywords.inject(0) { |score, keyword| score + notification.score(keyword) }

    Response.new(score)
  end
end
