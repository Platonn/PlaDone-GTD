class ChangeDoneInTasks < ActiveRecord::Migration
  def change
    change_column :tasks, :done, :boolean, :default => false

    Task.all.each do |t|
      t.update_attribute :done, false
    end
  end
end
