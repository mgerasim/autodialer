class CreateSpools < ActiveRecord::Migration[5.1]
  def change
    create_table :spools do |t|
      t.references :outgoing, foreign_key: true

      t.timestamps
    end
  end
end
