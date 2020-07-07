class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.string :title
      t.attachment :record

      t.timestamps
    end
  end
end
