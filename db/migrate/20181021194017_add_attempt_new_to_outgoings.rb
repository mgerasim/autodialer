class AddAttemptNewToOutgoings < ActiveRecord::Migration[5.1]
  def change
    add_column :outgoings, :attempt_current, :integer
  end
end
