class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :phone
      t.references :task, foreign_key: true

      t.timestamps
    end

  
  add_index :contacts, [:task_id, :created_at]

  end


end
