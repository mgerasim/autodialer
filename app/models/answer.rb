require 'csv'

class Answer < ApplicationRecord
    
    belongs_to :trank

    default_scope { order(created_at: :desc) }

    after_create :google_sheet_save 
   
    def self.to_csv
	attributes = %w{shown_date_created_at shown_time_created_at contact trank_name}
	
	CSV.generate({:headers => false, :col_sep => ';'}) do |csv|
	    
	    all.each do |answer|
	        csv << attributes.map{ |attr| answer.send(attr) }
	    end
	    
	end
    end

    def shown_date_created_at
        (created_at.localtime).strftime("%Y-%m-%d")
    end

    def shown_time_created_at
        (created_at.localtime).strftime("%H:%M:%S")
    end
 
    def trank_name
        trank.name
    end

    private

    def google_sheet_save
      # AnswerCreateJob.perform_later self
      begin
        puts "google_sheet_save"

        config = Config.first

        exit if !config.is_google_integrated  
       
        puts "config.is_google_integrated"

         setting = Setting.first

      session = GoogleDrive::Session.from_service_account_key("/home/rails/projects/autodialer/public/system/settings/google_private_keys/000/000/004/original/avtoobzvon-220208-7622b8c4a673.json") #setting.google_private_key.path)

      spreadsheet = session.spreadsheet_by_title(setting.google_title)

      worksheet = spreadsheet.worksheets[ id %  spreadsheet.worksheets.count]

      row = [shown_date_created_at, shown_time_created_at, contact]

      worksheet.insert_rows(worksheet.num_rows + 1, [row])
    
      worksheet.save 
    
    rescue => error
      
      puts error.message

    end
    end
end
