require 'csv'

class Answer < ApplicationRecord
    default_scope { order(created_at: :desc) }

    after_create :google_sheet_save 
    
    def self.to_csv
	attributes = %w{shown_date_created_at shown_time_created_at contact}
	
	CSV.generate({:headers => false, :col_sep => ';'}) do |csv|
	    
	    all.each do |answer|
	        csv << attributes.map{ |attr| answer.send(attr) }
	    end
	    
	end
    end

    def shown_date_created_at
        (created_at - 3.hours).strftime("%Y-%m-%d")
    end

    def shown_time_created_at
        (created_at - 3.hours).strftime("%H:%M:%S")
    end

    private

    def google_sheet_save
    	
    	session = GoogleDrive::Session.from_service_account_key("config//avtodialer.json")

    	spreadsheet = session.spreadsheet_by_title("Avtodialer")

    	puts spreadsheet.worksheets.count

    	worksheet = spreadsheet.worksheets[ id %  spreadsheet.worksheets.count]

    	row = [shown_date_created_at, shown_time_created_at, contact]

    	worksheet.insert_rows(worksheet.num_rows + 1, [row])

    	worksheet.save 

    end
end
