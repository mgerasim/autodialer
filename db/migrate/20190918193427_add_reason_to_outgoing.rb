class AddReasonToOutgoing < ActiveRecord::Migration[5.1]
  def change
    add_column :outgoings, :reason, :integer
  end
end
