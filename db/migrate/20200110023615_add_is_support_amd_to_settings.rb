class AddIsSupportAmdToSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :is_support_amd, :boolean
  end
end
