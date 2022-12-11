class AddEnableToVehiculos < ActiveRecord::Migration[7.0]
  def change
    add_column :vehiculos, :enable, :boolean, default: true
  end
end
