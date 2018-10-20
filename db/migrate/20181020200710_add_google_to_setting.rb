class AddGoogleToSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :google_title, :text
  end
end
