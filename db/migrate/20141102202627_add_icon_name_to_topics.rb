class AddIconNameToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :icon_name, :string
  end
end
