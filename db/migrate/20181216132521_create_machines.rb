class CreateMachines < ActiveRecord::Migration[5.1]
  def change
    create_table :machines do |t|
      t.string :telephone
      t.string :amdstatus
      t.string :amdcause

      t.timestamps
    end
  end
end
