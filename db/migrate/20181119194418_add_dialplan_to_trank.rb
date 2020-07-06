class AddDialplanToTrank < ActiveRecord::Migration[5.1]
  def change
    add_reference :tranks, :dialplan, foreign_key: true
  end
end
