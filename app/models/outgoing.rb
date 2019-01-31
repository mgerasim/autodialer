class Outgoing < ApplicationRecord
  
    include ActiveModel::Validations

    attr_accessor :csv_upload

    belongs_to :trank, required: false

    def shown_date_created_at
	if (updated_at != nil)
        	(updated_at).strftime("%Y-%m-%d")
	else
		""
	end
    end

    def shown_time_created_at
	if (updated_at != nil)
        	(updated_at).strftime("%H:%M:%S")
	else
		""
	end
    end

    def google_sheet_save(title)
      begin

      config = Config.first

      exit if !config.is_google_integrated  

      setting = Setting.first

      session = GoogleDrive::Session.from_service_account_key("/home/rails/projects/autodialer/public/system/settings/google_private_keys/000/000/004/original/avtoobzvon-220208-7622b8c4a673.json") 

     puts title

      spreadsheet = session.spreadsheet_by_title(title)

      worksheet = spreadsheet.worksheets[ id %  spreadsheet.worksheets.count]

      row = [shown_date_created_at, shown_time_created_at,telephone]

      worksheet.insert_rows(worksheet.num_rows + 1, [row])
    
      worksheet.save 
    
    rescue => error
      
      puts error.message

    end
end
end
