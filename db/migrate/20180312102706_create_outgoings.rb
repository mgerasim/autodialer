class CreateOutgoings < ActiveRecord::Migration[5.1]
  def change
    create_table :outgoings do |t|
      t.string :telephone

      t.timestamps
    end
  end
end
