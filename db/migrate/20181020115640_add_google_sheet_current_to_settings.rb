class AddGoogleSheetCurrentToSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :google_sheet_current, :integer, :default => 0
  end
end
