class CreateDialplans < ActiveRecord::Migration[5.1]
  def change
    create_table :dialplans do |t|
      t.string :title
      t.string :name

      t.timestamps
    end
  end
end
