class AddStatusToTask < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :status, :string
  end
end
