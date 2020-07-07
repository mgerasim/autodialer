class CreateSipaccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :sipaccounts do |t|
      t.string :number
      t.string :password

      t.timestamps
    end
  end
end
