class AddColumnAndDeleteColumnToCoins < ActiveRecord::Migration[5.1]
  def up
    add_column :coins, :coin_market_cap_id, :string, null: false, :after => :id
    add_column :coins, :symbol, :string, null: false, :after => :name
    add_column :coins, :rank, :integer, null: false, :after => :symbol
    add_column :coins, :market_cap_jpy, :string, null: false, :after => :rank

    remove_column :coins, :name_kana
    remove_column :coins, :market_rank
  end

  def down
    add_column :coins, :name_kana, :string
    add_column :coins, :market_rank, :integer

    remove_column :coins, :coin_market_cap_id
    remove_column :coins, :symbol
    remove_column :coins, :rank
    remove_column :coins, :market_cap_jpy
  end
end
