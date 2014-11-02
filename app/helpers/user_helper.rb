module UserHelper
  def logged?
    current_user
  end

  def is_admin?
    logged? && current_user.admin
  end

  def user_topics
    current_user.topics
  end
end
