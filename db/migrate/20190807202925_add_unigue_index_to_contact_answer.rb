class AddUnigueIndexToContactAnswer < ActiveRecord::Migration[5.1]
  def change
 	add_index :answers, :contact, unique: true
  end
end
