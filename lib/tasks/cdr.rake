namespace :cdr do
  desc "TODO"
  task update: :environment do
    Outgoing
      .where(status: "DIALING")
      .where("updated_at > ? ", Time.now - 1.hours)
      .where("updated_at < ? ", Time.now - 5.minute)
      .order(updated_at: :desc)   do |contact|

             contact.update_attribute(:status, "DIALED")
      
             cdr =  Asteriskcdr.where(src: contact.id.to_s).first 
             if (cdr != nil) 
               contact.update_attribute(:status, cdr.disposition)
              end
      
      end
  end


  desc "TODO"
  task run:  :environment do
    
  end
end
