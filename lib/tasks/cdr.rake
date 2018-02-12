namespace :cdr do
  desc "TODO"
  task update: :environment do
    Contact.where(status: "DIALING").count do |contact|
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
