class AgregarCompra < ActiveRecord::Migration[7.0]
  def change
    create_table :compras do |t|
      t.string :medio_de_pago
      t.float :monto, null: false, default: 0.0
      t.timestamps null: false
    end
  end
end
