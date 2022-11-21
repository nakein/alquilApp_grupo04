class AgregarCampoEstadoAlquiler < ActiveRecord::Migration[7.0]
  def change
    add_column :alquilers, :status, :integer
  end
end
