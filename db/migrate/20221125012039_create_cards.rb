class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.integer :card_type
      t.string :digits
      t.string :security_code
      t.date :exp_date
      t.float :money, null: false, default: 0.0
      t.belongs_to :billetera
      t.timestamps
    end
  end
end
