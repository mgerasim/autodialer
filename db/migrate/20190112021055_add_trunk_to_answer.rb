class AddTrunkToAnswer < ActiveRecord::Migration[5.1]
  def change
    add_reference :answers, :trank, foreign_key: true
  end
end
