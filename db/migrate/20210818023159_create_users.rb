class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: false do |t|
      t.string :line_user_id, null: false, index: { unique: true }, primary_key: true
      t.datetime :friend_registration_datetime, null: false
      t.boolean :is_blocked, default: false, null: false
    end
  end
end
