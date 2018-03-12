class AddIsEnabledToSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :is_enabled, :boolean
  end
end
