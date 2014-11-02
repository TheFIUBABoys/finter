class AddOriginalDateToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :original_date, :datetime
  end
end
