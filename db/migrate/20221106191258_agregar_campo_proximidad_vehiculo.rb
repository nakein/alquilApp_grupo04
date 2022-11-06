class AgregarCampoProximidadVehiculo < ActiveRecord::Migration[7.0]
  def change
    add_column :vehiculos, :proximity, :integer
  end
end
