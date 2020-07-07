class CreateAnalyses < ActiveRecord::Migration[5.1]
  def change
    create_table :analyses do |t|
      t.integer :employee_active_count
      t.integer :setting_trunk_active_count
      t.integer :trunk_enable_count
      t.integer :outgoing_count
      t.integer :answer_count

      t.timestamps
    end
  end
end
