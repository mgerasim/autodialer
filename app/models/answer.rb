require 'csv'

class Answer < ApplicationRecord
    default_scope { order(created_at: :desc) }
    
    def self.to_csv
	attributes = %w{shown_date_created_at shown_time_created_at contact}
	
	CSV.generate({:headers => false, :col_sep => ';'}) do |csv|
	    
	    all.each do |answer|
	        csv << attributes.map{ |attr| answer.send(attr) }
	    end
	    
	end
    end

    def shown_date_created_at
        created_at.strftime("%Y-%m-%d")
    end

    def shown_time_created_at
        created_at.strftime("%H:%M:%S")
    end
end
