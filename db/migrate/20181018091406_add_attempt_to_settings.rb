class AddAttemptToSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :attempt_max_count, :integer, :default => 0
    add_column :settings, :attempt_interval, :integer, :default => 60
  end
end
