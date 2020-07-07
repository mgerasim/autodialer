class AddIsSupportCallDeltaToSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :is_support_call_delta, :boolean
  end
end
