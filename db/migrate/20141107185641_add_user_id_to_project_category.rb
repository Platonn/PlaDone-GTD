class AddUserIdToProjectCategory < ActiveRecord::Migration
  def change
    add_column :project_categories, :user_id, :integer
  end
end
