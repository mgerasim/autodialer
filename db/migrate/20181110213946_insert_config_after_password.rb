class InsertConfigAfterPassword < ActiveRecord::Migration[5.1]
  def change
    if (Config.count == 0)
      Config.create(:password_encrypted => "", :is_outgoing_deleted => false, :is_outgoing_table_showed => false, :is_google_integrated => false, :is_attempt_supported => false, :is_answer_supported => false ) 
    end
  end
end
