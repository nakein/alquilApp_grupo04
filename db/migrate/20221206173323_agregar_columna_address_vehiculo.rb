class AgregarColumnaAddressVehiculo < ActiveRecord::Migration[7.0]
  def change
    add_column :vehiculos, :address, :string
  end
end
