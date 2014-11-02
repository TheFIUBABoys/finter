class CreateTopicNotifications < ActiveRecord::Migration
  def change
    create_table :topic_notifications do |t|
      t.belongs_to :notification
      t.belongs_to :topic
      t.timestamps
    end
  end
end
