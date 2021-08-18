class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :user_id
      t.datetime :timestamp

      t.timestamps
    end
  end
end
