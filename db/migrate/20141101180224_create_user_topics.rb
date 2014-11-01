class CreateUserTopics < ActiveRecord::Migration
  def change
    create_table :user_topics do |t|
      t.belongs_to :user
      t.belongs_to :topic
      t.timestamps
    end
  end
end
