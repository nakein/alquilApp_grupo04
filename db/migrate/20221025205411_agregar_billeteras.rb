class AgregarBilleteras < ActiveRecord::Migration[7.0]
  def change
    create_table :billeteras do |t|
      t.float :saldo, null: false, default: 0.0
      t.belongs_to :usuario
      t.has_one :compra
      t.timestamps null: false
    end
  end
end
