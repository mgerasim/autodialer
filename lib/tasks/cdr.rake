namespace :cdr do

  desc "TODO"
  task attempt: :environment do

	begin
		setting = Setting.first
		contacts = Outgoing.where("attempt < ?", setting.attempt_max_count)
			.where(status: ['NO ANSWER', 'FAILED'])
			.order(updated_at: :desc)
		puts contacts.count
		contacts.each do |contact|
			contact.update_attributes(:status => "INSERTED",
				:attempt => setting.attempt + 1)
		end
	rescue => error
		puts error.message
	end
  end

  desc "TODO"
  task update: :environment do

	begin	

		puts Outgoing.all.count

		contacts = Outgoing.where(status: "DIALING")
			.where("updated_at > ? ", Time.now.utc - 24.hours)
			.where("updated_at < ? ", Time.now.utc - 1.minute)
			.order(updated_at: :desc)

		puts contacts.count 

   		contacts.each do |contact|

			if (contact.attempt == nil)
				puts "attempt == nil"
				contact.update_attributes(:status => 'DIALED', :attempt => 0)
			else 
				puts "attempt != nil"
				contact.update_attributes(:status => 'DIALED')
      			end

             		cdr =  Asteriskcdr.where(accountcode: contact.id.to_s).first 
             
			if (cdr != nil) 
               			contact.update_attribute(:status, cdr.disposition)
              		end
      
     	 	end

	rescue => error

		puts error.message

	end
  end


  desc "TODO"
  task run:  :environment do
    
  end
end
