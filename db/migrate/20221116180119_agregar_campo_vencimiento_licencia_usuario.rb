class AgregarCampoVencimientoLicenciaUsuario < ActiveRecord::Migration[7.0]
  def change
    add_column :usuarios, :license_expiration_date, :date
  end
end
