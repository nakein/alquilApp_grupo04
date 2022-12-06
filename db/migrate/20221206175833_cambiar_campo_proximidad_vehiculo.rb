class CambiarCampoProximidadVehiculo < ActiveRecord::Migration[7.0]
  def change
    change_column :vehiculos, :proximity, :float
  end
end
