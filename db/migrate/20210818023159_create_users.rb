class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :line_user_id
      t.datetime :friend_registration_datetime

      t.timestamps
    end
  end
end
