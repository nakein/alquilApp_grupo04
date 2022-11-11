class AgregarCampoProximidadVehiculo < ActiveRecord::Migration[7.0]
  def change
    add_column :vehiculos, :proximity, :integer, default: 100
  end
end
