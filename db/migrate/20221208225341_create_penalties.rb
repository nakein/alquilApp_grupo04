class CreatePenalties < ActiveRecord::Migration[7.0]
  def change
    create_table :penalties do |t|
      t.string :motivo
      t.string :descripcion
      t.integer :tarifa
      t.belongs_to :usuario

      t.timestamps
    end
  end
end
