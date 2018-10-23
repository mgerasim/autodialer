namespace :cdr do

  desc "TODO"
  task attempt: :environment do

	begin
		setting = Setting.first
		contacts = Outgoing.where("attempt_current < ?", setting.attempt_max_count)
			.where(status: ['NO ANSWER', 'FAILED'])
			.order(updated_at: :desc)
		puts contacts.count
		contacts.each do |contact|
			contact.update_attributes(:status => "INSERTED",
				:attempt_current => contact.attempt_current + 1)
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
			.where("updated_at < ? ", Time.now.utc - 2.minute)
			.order(updated_at: :desc)

		puts contacts.count 

   		contacts.each do |contact|

			if (contact.attempt_current == nil)
				puts "attempt_current == nil"
				contact.update_attributes(:status => 'DIALED', :attempt_current => 0)
			else 
				puts "attempt_current != nil"
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
