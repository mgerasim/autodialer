namespace :dial do
  desc "TODO"
  task clear: :environment do
    `rm -rf /var/log/asterisk/cdr-csv/`
    `mkdir /var/log/asterisk/cdr-csv/`


    Outgoing
      .where("status != 'INSERTED'")
      .where("updated_at < ? ", Time.now - 20.hours)
      .order(updated_at: :desc)   do |contact|

             contact.delete
      
      end
  end

  

  task :answer, [:contact] => :environment do |t, args|
    
	puts args.contact
	
	Answer.create(:contact => args.contact)    
  end
 
  desc "TODO"
  task run: :environment do
  
    puts Time.now.strftime("  %F %T")
    
    wc1 = `ps aux | grep -i "rake dial:run" | grep -v "grep" | wc -l`.split("\n")
    
    setting = Setting.first
    
    if (setting == nil)    
	setting = Setting.new
	setting.hour_bgn = 0
	setting.hour_end = 24
	setting.sleep = 1
	setting.outgoing = '/var/spool/asterisk/outgoing'
	setting.save
    end
    
    if (setting.hour_bgn == nil)
        setting.update_attributes(:hour_bgn => 0)
    end

    if (setting.hour_end == nil)
    	setting.update_attributes(:hour_end => 24)
    end 
   
    if (!(setting.hour_bgn <= Time.now.hour and Time.now.hour < setting.hour_end))
	exit
    end
    
    total = (60 / setting.sleep).floor
    
    for t in 0..total 
        
       puts Time.now.strftime("    %F %T")
        
        sleep setting.sleep
        
        wc = `ps aux | grep -i "rake dial:run" | grep -v "grep" | wc -l`.split("\n")
        puts wc
        next if (wc == 2 and wc1 == 2)

        Trank.all.each do |trank|
            puts "#{trank.name}"
            next if (!trank.enabled)
               
            puts "Этот транк активный"

            dir = setting.outgoing + '/'
            count = Dir[File.join(dir, '**', "*#{trank.name}*")].count { |file| File.file?(file) }
            j = count
            puts "->#{count}"
            next   if (count >= trank.callcount)

            n = 0
            Outgoing.where(:status => 'INSERTED').order(updated_at: :desc).limit(trank.callcount).each do |contact|                

		if (contact.telephone == '')
			contact.delete
			next
		end

                contact.update_attributes(:status => 'DIALING')
                
                n = n + 1
                j = j + 1
                f_path = ""
    	        
                telephone = contact.telephone.gsub(/[^0-9A-Za-z]/, '').gsub(/\r\n?/, "\n").gsub(/\W/, '')    
    	        if (telephone.length == 11)
    	            telephone.slice!(0)
    	        end
   
                if (telephone.length == 10) 
                    telephone = '7' + telephone
                end

                telephone = trank.prefix + telephone
            
                puts telephone

                trank.check(telephone, contact.id) 

                dir = setting.outgoing + '/'
                count = Dir[File.join(dir, '**', "*#{trank.name}*")].count { |file| File.file?(file) }
                puts "-->#{count}"


              
                if (j > trank.callcount)
                    j = 0
                    next
                end
            end
        end 
        
    end
    
  end

end
