class AddIndexStatusToOutgoing < ActiveRecord::Migration[5.1]
  def change
    add_index :outgoings, :status
  end
end
