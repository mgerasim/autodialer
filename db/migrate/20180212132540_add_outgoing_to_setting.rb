class AddOutgoingToSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :outgoing, :string
  end
end
