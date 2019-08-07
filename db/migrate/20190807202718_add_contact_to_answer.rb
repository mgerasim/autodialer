class AddContactToAnswer < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :contact, :bigint
  end
end
