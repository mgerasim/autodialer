class AddTrunkActiveCountToSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :trunk_active_count, :integer
  end
end
