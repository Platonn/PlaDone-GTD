class AddUserIdToContext < ActiveRecord::Migration
  def change
    add_column :contexts, :user_id, :integer
  end
end
