class AgregarCamposRegistroUsuario < ActiveRecord::Migration[7.0]
  def change
    add_column :usuarios, :fullname, :string
    add_column :usuarios, :dni, :integer
    add_column :usuarios, :birthdate, :date
  end
end
