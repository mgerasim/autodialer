class AddWaittimeToSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :waittime, :integer
  end
end
