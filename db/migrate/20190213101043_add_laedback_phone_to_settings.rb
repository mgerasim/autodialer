class AddLaedbackPhoneToSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :leadback_phone, :string
  end
end
