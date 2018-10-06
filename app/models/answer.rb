require 'csv'

class Answer < ApplicationRecord
    default_scope { order(created_at: :desc) }
    
    def self.to_csv
	attributes = %w{created_at contact}
	
	CSV.generate(headers: true) do |csv|
	    csv << attributes
	    
	    all.each do |answer|
	        csv << attributes.map{ |attr| answer.send(attr) }
	    end
	    
	end
    end
end
