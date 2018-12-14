class CreateCoinShops < ActiveRecord::Migration[5.1]
  def change
    create_table :coin_shops do |t|
      t.references :coin, foreign_key: true
      t.references :shop, foreign_key: true

      t.timestamps
    end
  end
end
