class AddAttemptToOutgoings < ActiveRecord::Migration[5.1]
  def change
    add_column :outgoings, :attempt, :integer, :default => 0
  end
end
