class CreateProjectLogEntries < ActiveRecord::Migration
  def change
    create_table :project_log_entries do |t|
      t.integer :project_id,      :null => false
      t.integer :user_id,         :null => false
      t.integer :activity_type,   :null => false
      t.integer :task_id
      t.string  :previous_value
      t.string  :new_value

      t.timestamps
    end
  end
end
