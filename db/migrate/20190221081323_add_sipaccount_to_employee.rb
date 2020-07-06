class AddSipaccountToEmployee < ActiveRecord::Migration[5.1]
  def change
    add_reference :employees, :sipaccount, foreign_key: true
  end
end
