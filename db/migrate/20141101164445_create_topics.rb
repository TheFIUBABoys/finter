class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.boolean :promoted
      t.string :twitter_keywords

      t.timestamps
    end
  end
end
