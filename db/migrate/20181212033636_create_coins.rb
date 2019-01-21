class CreateCoins < ActiveRecord::Migration[5.1]
  def change
    create_table :coins do |t|
      t.string :name, null: false
      t.string :name_kana
      t.integer :market_rank, null: false
      t.timestamps
    end

    add_index :coins, :name, :unique => true
    add_index :coins, :market_rank, :unique => true
  end
end
