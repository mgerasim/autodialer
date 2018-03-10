class AddSleepToSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :sleep, :integer
  end
end
