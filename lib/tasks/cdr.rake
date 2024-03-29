namespace :cdr do

  desc "TODO"
  task spool: :environment do
    config = Config.first
    exit if config.is_outgoing_deleted 
    spools = Spool.all.limit(10)
    spools.each do |spool|
      puts spool.outgoing.telephone
      telephone = spool.outgoing.telephone
      trank = spool.trank
      spool.delete
      Answer.create(:contact => telephone.squish, :trank => trank)
    end
  end

  desc "TODO"
  task answer: :environment do

    config = Config.first
    exit if config.is_outgoing_deleted

    cdr = Asteriskcdr.where(:lastapp => 'System').where("calldate > ?", Time.now - 8.hours).order(calldate: :desc).limit(10)

    cdr.each do |record|
        record.update_attributes(:lastapp => 'System01')
        telephone = Outgoing.where(:id => record.accountcode.to_i).first
        if (telephone != nil)
            Answer.create(:contact => telephone.telephone)
        end
    end
  end

  desc "TODO"
  task attempt: :environment do

	begin
		config = Config.first
    		exit if config.is_outgoing_deleted
		
		setting = Setting.first

		contacts = Outgoing.where("attempt_current < ?", setting.attempt_max_count)
			.where(status: ['NO ANSWER', 'FAILED'])
			.where("updated_at < ?", Time.now - setting.attempt_interval.minutes)
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
		config = Config.first
		exit if config.is_outgoing_deleted
	
		contacts = Outgoing.where(status: "DIALING")
			.where("updated_at > ? ", Time.now.utc - 24.hours)
			.where("updated_at < ? ", Time.now.utc - 1.minute)
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
				puts cdr.dcontext
				if (cdr.dcontext == 'outgoing-finish')
			
					puts 'outgoing-finish'
				      
                                      #  contact.google_sheet_save('Avtoobzvon1')	
					
					Answer.create(:contact => contact.telephone, :level => 1)
				end				

				if (cdr.dcontext == 'outgoing-push-two')

					puts 'outgoing-push-two'

				#	contact.google_sheet_save('Avtoobzvon2')	
					Answer.create(:contact => contact.telephone, :level => 2)		
				end

             			contact.update_attribute(:status, cdr.disposition)
			else 
				puts "cdr is nil"
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
