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
      t.references :user, null: false, foreign_key: true

    end
  end
end
