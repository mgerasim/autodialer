class AddTrunkToOutgoing < ActiveRecord::Migration[5.1]
  def change
    add_reference :outgoings, :trank, foreign_key: true
  end
end
