class AddHourBgnToSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :hour_bgn, :integer
  end
end
