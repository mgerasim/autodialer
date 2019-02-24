class AddAnswerToLead < ActiveRecord::Migration[5.1]
  def change
    add_reference :leads, :answer, foreign_key: true
  end
end
