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
	
    def self.total_count
        date = DateTime.now
                Outgoing.where(:updated_at => (date.beginning_of_day..date.end_of_day)).count
       # Outgoing.where(:updated_at => (date.beginning_of_day..date.end_of_day))
 #      .where(:status => ["DIALED", "ANSWERED", "NO ANSWER", "FAILED", "BUSY"]).count
    end

    def self.answer_total_count
        date = DateTime.now
        Answer.where(:updated_at => (date.beginning_of_day..date.end_of_day)).count
    end

    def self.outgoing_precent
        outgoing_count = self.total_count

       if outgoing_count == 0
           0
       else
            ((self.answer_total_count.to_f / total_count.to_f) * 100).round(2)
       end
    end


    def self.outgoing_answer_total_count
        date = DateTime.now
       Outgoing.where(:updated_at => (date.beginning_of_day..date.end_of_day))
        .where(:status => ["ANSWERED"]).count
    end

    def self.outgoing_answer_precent
        outgoing_answer_count = self.outgoing_answer_total_count

        if outgoing_answer_count == 0
            0
        else
            ((answer_total_count.to_f / outgoing_answer_total_count.to_f) * 100).round(2)
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
