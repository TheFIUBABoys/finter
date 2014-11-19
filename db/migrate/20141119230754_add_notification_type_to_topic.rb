class AddNotificationTypeToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :notification_type, :string
  end
end
