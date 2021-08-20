class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :code, null: false, index: { unique: true }
      t.integer :brand_id, null: false
      t.integer :item_id, null: false
      t.string :url, null: false, index: { unique: true }
      t.string :status, default: 'issued', null: false
      t.integer :issued_at, null: false
      t.integer :exchanged_at
      t.string :line_user_id, null: false
    end
    add_foreign_key :tickets, :users, column: :line_user_id, primary_key: "line_user_id"
  end
end
