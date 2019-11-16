class GroupTrunkJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :tranks, :groups do |t|
      t.references :trank, foreign_key: true
      t.references :group, foreign_key: true
    end
  end
end
