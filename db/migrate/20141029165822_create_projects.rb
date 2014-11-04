class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name

      t.integer :project_category_id

      t.timestamps
    end
  end
end
