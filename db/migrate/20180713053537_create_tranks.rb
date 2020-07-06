class CreateTranks < ActiveRecord::Migration[5.1]
  def change
    create_table :tranks do |t|
      t.string :name
      t.string :callerid
      t.integer :waittime
      t.integer :callcount
      t.boolean :enabled

      t.timestamps
    end
  end
end
