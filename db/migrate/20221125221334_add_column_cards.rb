class AddColumnCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :name, :string
    add_column :cards, :digits, :string
    add_column :cards, :security_code, :string
    add_column :cards, :exp_date, :date
    add_column :cards, :money, :float
  end
end
