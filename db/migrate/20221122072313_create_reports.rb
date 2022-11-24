class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :subject
      t.string :message
      t.integer :status, default: 0
      t.belongs_to :usuario
      t.timestamps
    end
  end
end
