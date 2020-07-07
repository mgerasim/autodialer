class AddStatusToOutgoing < ActiveRecord::Migration[5.1]
  def change
    add_column :outgoings, :status, :string
  end
end
