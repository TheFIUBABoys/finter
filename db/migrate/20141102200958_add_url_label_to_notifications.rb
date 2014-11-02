class AddUrlLabelToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :url_label, :string
  end
end
