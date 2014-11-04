class AddTimeNeededToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :time_needed, :string
  end
end
