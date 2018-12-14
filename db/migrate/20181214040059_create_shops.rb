class CreateShops < ActiveRecord::Migration[5.1]
  def change
    create_table :shops do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :company
      t.timestamps
    end
  end
end
