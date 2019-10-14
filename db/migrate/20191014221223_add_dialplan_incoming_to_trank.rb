class AddDialplanIncomingToTrank < ActiveRecord::Migration[5.1]
  def change
    add_reference :tranks, :dialplan_incoming, foreign_key: {to_table: :dialplans}
  end
end
