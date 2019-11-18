class AddDialtypeToSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :dialtype, :integer, :default => 1
  end
end
