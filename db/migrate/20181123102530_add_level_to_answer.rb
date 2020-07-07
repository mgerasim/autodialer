class AddLevelToAnswer < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :level, :integer
  end
end
