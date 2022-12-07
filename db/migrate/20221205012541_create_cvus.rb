class CreateCvus < ActiveRecord::Migration[7.0]
  def change
    create_table :cvus do |t|
      t.string :name
      t.string :digits
      t.string :alias
      t.float :money, null: false, default: 0.0
      t.belongs_to :billetera
      t.timestamps
    end
  end
end
