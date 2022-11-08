class AgregarCampoLicenciaUsuario < ActiveRecord::Migration[7.0]
  def change
    add_column :usuarios, :valid_license, :boolean, default: false
  end
end
