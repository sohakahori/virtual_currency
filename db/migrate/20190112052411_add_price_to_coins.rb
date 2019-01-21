class AddPriceToCoins < ActiveRecord::Migration[5.1]
  def change
    add_column :coins, :price, :string, after: :rank
  end
end
