class CreateTopicNotifications < ActiveRecord::Migration
  def change
    remove_column :notifications, :topic_id, :integer
    create_table :topic_notifications do |t|
      t.belongs_to :notification
      t.belongs_to :topic
      t.timestamps
    end
  end
end
