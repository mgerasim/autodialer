class Outgoing < ApplicationRecord
  
    include ActiveModel::Validations

    attr_accessor :csv_upload
  
    def shown_date_created_at
	if (updated_at != nil)
        	(updated_at - 3.hours).strftime("%Y-%m-%d")
	else
		""
	end
    end

    def shown_time_created_at
	if (updated_at != nil)
        	(updated_at - 3.hours).strftime("%H:%M:%S")
	else
		""
	end
    end

end
