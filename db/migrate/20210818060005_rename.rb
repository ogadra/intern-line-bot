class Rename < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :user_id, :line_user_id
    rename_column :users, :timestamp, :friend_registration_datetime
  end
end
