class CreateAlquilers < ActiveRecord::Migration[7.0]
  def change
    create_table :alquilers do |t|

      t.integer :user_id
      t.integer :vehicle_id

      t.timestamps
    end
  end
end
