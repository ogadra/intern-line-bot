class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :line_user_id, unique: true, null: false
      t.datetime :friend_registration_datetime, null: false
    end
  end
end
