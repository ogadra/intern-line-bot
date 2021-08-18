class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :line_user_id, null: false, index: { unique: true }
      t.datetime :friend_registration_datetime, null: false
      t.boolean :is_blocked
    end
  end
end
