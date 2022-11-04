class CreateVehiculos < ActiveRecord::Migration[7.0]
  def change
    create_table :vehiculos do |t|
      t.string :brand
      t.string :model
      t.string :color
      t.string :fuel_type
      t.integer :capacity
      t.string :transmission

      t.timestamps
    end
  end
end
