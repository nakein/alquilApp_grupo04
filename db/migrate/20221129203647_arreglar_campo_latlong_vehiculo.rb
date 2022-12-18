class ArreglarCampoLatlongVehiculo < ActiveRecord::Migration[7.0]
  def change
    add_column :vehiculos, :latitude, :float
    add_column :vehiculos, :longitude, :float
  end
end
