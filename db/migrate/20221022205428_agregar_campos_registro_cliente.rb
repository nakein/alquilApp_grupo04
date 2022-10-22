class AgregarCamposRegistroCliente < ActiveRecord::Migration[7.0]
  def change
    add_column :clientes, :fullname, :string
    add_column :clientes, :dni, :integer
    add_column :clientes, :birthdate, :date
  end
end
