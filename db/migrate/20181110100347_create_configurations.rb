class CreateConfigurations < ActiveRecord::Migration[5.1]
  def change
    create_table :configurations do |t|
      t.text :password_encrypted
      t.boolean :is_outgoing_deleted
      t.boolean :is_outgoing_table_showed
      t.boolean :is_google_integrated
      t.boolean :is_attempt_supported
      t.boolean :is_answer_supported

      t.timestamps
    end
  end
end
