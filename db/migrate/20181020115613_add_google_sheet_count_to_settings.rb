class AddGoogleSheetCountToSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :google_sheet_count, :integer
  end
end
