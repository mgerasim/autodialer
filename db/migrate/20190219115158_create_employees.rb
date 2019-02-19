class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :password
      t.integer :status

      t.timestamps
    end
  end
end
