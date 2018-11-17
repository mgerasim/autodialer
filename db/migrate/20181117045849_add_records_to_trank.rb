class AddRecordsToTrank < ActiveRecord::Migration[5.1]
  def change
    add_reference :tranks, :vote_welcome, foreign_key: { to_table: :votes }
    add_reference :tranks, :vote_finish, foreign_key: { to_table: :votes }
    add_reference :tranks, :vote_push_two, foreign_key: { to_table: :votes } 
  end
end
