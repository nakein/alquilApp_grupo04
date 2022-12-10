class AgregarCampoValidacionUsuario < ActiveRecord::Migration[7.0]
  def change
    add_column :usuarios, :validated, :boolean
  end
end
