class CambiarCoordenadas < ActiveRecord::Migration[7.0]
  def change
    change_column :usuarios, :latitude, :float, default: -34.903445
    change_column :usuarios, :longitude, :float, default: -57.938195
  end
end
