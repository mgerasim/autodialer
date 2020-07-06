class AddTrunkToSpool < ActiveRecord::Migration[5.1]
  def change
    add_reference :spools, :trank, foreign_key: true
  end
end
