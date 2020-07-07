class AddEmployeeToLead < ActiveRecord::Migration[5.1]
  def change
    add_reference :leads, :employee, foreign_key: true
  end
end
