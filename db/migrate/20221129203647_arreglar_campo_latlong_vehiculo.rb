class ArreglarCampoLatlongVehiculo < ActiveRecord::Migration[7.0]
  def change
    remove_column :vehiculos, :location_point, :point
    add_column :vehiculos, :latitude, :float
    add_column :vehiculos, :longitude, :float
  end
end
