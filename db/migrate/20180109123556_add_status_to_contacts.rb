class AddStatusToContacts < ActiveRecord::Migration[5.1]
  def change
    add_column :contacts, :status, :string
  end
end
