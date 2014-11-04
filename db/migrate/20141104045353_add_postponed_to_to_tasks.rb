class AddPostponedToToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :postponed_to, :date
  end
end
