class AddCurrentcountToSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :currentcount, :integer
  end
end
