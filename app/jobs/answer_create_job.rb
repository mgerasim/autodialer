class AnswerCreateJob < ApplicationJob
  queue_as :urgent

  def perform(answer)
    
    begin
  
      setting = Setting.first

      session = GoogleDrive::Session.from_service_account_key("/home/rails/projects/autodialer/public/system/settings/google_private_keys/000/000/004/original/avtoobzvon-220208-7622b8c4a673.json") #setting.google_private_key.path)

      spreadsheet = session.spreadsheet_by_title(setting.google_title)

      worksheet = spreadsheet.worksheets[ answer.id %  spreadsheet.worksheets.count]

      row = [answer.shown_date_created_at, answer.shown_time_created_at, answer.contact]

      worksheet.insert_rows(worksheet.num_rows + 1, [row])
    
      worksheet.save 
    
    rescue => error
      
      puts error.message

    end

  end
end
