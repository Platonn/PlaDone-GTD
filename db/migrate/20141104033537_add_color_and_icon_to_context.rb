class AddColorAndIconToContext < ActiveRecord::Migration
  def change
    add_column :contexts, :color, :string
    add_column :contexts, :icon, :string
  end
end
