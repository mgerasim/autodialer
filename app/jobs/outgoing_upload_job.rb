class OutgoingUploadJob < ApplicationJob
  queue_as :default

  def perform(path)
	Rails.logger.error path
	
	upload = "LOAD DATA LOCAL INFILE '" + path + "' INTO TABLE outgoings (telephone) SET date_created = CURRENT_TIMESTAMP, status = 'INSERTED';"	
	
	results = ActiveRecord::Base.connection.execute(upload)
	
	Rails.logger.error results
  end
end
