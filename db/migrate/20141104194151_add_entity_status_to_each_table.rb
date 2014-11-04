class AddEntityStatusToEachTable < ActiveRecord::Migration
  def change
    add_column :tasks, :deleted_at, :time
    add_column :contexts, :deleted_at, :time
    add_column :projects, :deleted_at, :time
    add_column :project_categories, :deleted_at, :time
  end
end
