class AddCallDeltaToSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :call_delta, :integer
  end
end
