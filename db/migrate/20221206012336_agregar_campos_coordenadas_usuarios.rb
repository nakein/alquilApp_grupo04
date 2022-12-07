class AgregarCamposCoordenadasUsuarios < ActiveRecord::Migration[7.0]
  def change
    add_column :usuarios, :latitude, :float, default: -34.9213
    add_column :usuarios, :longitude, :float, default: -57.9545
  end
end
