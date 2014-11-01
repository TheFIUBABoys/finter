class AddTopicIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :topic_id, :integer
    add_index  :notifications, :topic_id
  end
end
