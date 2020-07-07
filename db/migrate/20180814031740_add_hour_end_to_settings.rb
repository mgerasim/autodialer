class AddHourEndToSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :hour_end, :integer
  end
end
