class Users < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_blocked, :boolean
  end
end
