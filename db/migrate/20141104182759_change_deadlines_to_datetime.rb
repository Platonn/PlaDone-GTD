class ChangeDeadlinesToDatetime < ActiveRecord::Migration
  def change
    change_column :tasks, :deadline, :datetime
    change_column :projects, :deadline, :datetime
  end
end
