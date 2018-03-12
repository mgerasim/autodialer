class AddDateCreatedToOutgoing < ActiveRecord::Migration[5.1]
  def change
    add_column :outgoings, :date_created, :datetime
  end
end
