class AgregarCampoHorasAlquiler < ActiveRecord::Migration[7.0]
  def change
    add_column :alquilers, :hours, :integer
  end
end
