class AgregarCampoLocationVehiculos < ActiveRecord::Migration[7.0]
  def change
    remove_column :vehiculos, :location_point, :point
  end
end
