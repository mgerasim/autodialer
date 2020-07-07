class AddDialFieldToGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :waittime, :integer
    add_column :groups, :callcount, :integer
    add_column :groups, :is_enabled, :boolean
    add_column :groups, :callmax, :integer
    add_column :groups, :sleeptime, :integer
  end
end
