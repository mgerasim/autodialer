class AddLaedbackPhoneToConfig < ActiveRecord::Migration[5.1]
  def change
    add_column :configs, :leadback_phone, :string
  end
end
