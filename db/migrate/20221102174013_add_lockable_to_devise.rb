class AddLockableToDevise < ActiveRecord::Migration[7.0]
  def change
    add_column :usuarios, :failed_attempts, :integer, default: 0, null: false # Only if lock strategy is :failed_attempts
    add_column :usuarios, :locked_at, :datetime

    # Add these only if unlock strategy is :email or :both
    add_column :usuarios, :unlock_token, :string
    add_index :usuarios, :unlock_token, unique: true
  end
end
