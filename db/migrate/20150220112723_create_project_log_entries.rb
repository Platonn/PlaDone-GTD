class CreateProjectLogEntries < ActiveRecord::Migration
  def change
    create_table :project_log_entries do |t|
      t.integer :project_id
      t.integer :task_id
      t.integer :user_id
      t.integer :activity_type

      t.timestamps
    end
  end
end
