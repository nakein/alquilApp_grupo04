class AgregarCampoPatenteVehiculo < ActiveRecord::Migration[7.0]
  def change
    add_column :vehiculos, :license_plate, :string
  end
end
