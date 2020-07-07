class RemoveAttemptFromOutgoings < ActiveRecord::Migration[5.1]
  def change
    remove_column :outgoings, :attempt, :integer
  end
end
