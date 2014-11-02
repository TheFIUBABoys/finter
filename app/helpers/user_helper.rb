module UserHelper
  def logged?
    current_user
  end

  def is_admin?
    logged? && current_user.admin
  end
end
