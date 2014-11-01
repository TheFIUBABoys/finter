class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :body
      t.string :url
      t.boolean :promoted
      t.string :twitter_handle

      t.timestamps
    end
  end
end
