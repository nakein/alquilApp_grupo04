class CreateRates < ActiveRecord::Migration[7.0]
  def change
    create_table :rates do |t|
      t.string :rent_name
      t.integer :rent_price
      t.string :extension_name
      t.integer :extension_price
      t.string :penalty_name
      t.integer :penalty_price
      t.string :gas_name
      t.integer :gas_price

      t.timestamps
    end
  end
end
