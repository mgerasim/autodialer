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
        (created_at.localtime).strftime("%Y-%m-%d")
    end

    def shown_time_created_at
        (created_at.localtime).strftime("%H:%M:%S")
    end

    private

    def google_sheet_save
       AnswerCreateJob.perform_later self
    end
end
