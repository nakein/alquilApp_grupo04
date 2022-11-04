class AgregarCompra < ActiveRecord::Migration[7.0]
  def change
    create_table :compras do |t|
      t.string :medio_de_pago
      t.string :datos_cuenta
      t.float :monto, null: false, default: 0.0
      t.belongs_to :billetera
      t.timestamps null: false
    end
  end
end
