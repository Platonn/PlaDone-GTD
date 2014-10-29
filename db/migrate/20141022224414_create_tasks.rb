class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.date :deadline
      t.integer :time_needed
      t.boolean :done

      t.timestamps
    end
  end
end
