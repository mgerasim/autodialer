class AddTrankToSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :trank, :string
  end
end
