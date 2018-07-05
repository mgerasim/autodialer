namespace :dial do
  desc "TODO"
  task clear: :environment do
    `rm -rf /var/log/asterisk/cdr-csv/`
    `mkdir /var/log/asterisk/cdr-csv/`
  end
 
  desc "TODO"
  task run: :environment do
  
    puts Time.now.strftime("  %F %T")
    
    wc1 = `ps aux | grep -i "rake dial:run" | grep -v "grep" | wc -l`.split("\n")
    
    setting = Setting.first
    total = (60 / setting.sleep).floor
    
    for t in 0..total 
        
       puts Time.now.strftime("    %F %T")
        
        sleep setting.sleep
        
        wc = `ps aux | grep -i "rake dial:run" | grep -v "grep" | wc -l`.split("\n")
        
        puts wc
        
        next if (wc == 2 and wc1 == 2)
        
        next if (setting.is_enabled != true)
        dir = setting.outgoing + '/'
        count = Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }
        j = count
        
        next   if (count > setting.callcount)
        
        n = 0
        
        Outgoing.limit(setting.callcount).each do |contact|
        
                    
            contact.delete
            
       
            n = n + 1
            j = j + 1
       
            f_path = ""
       
            peers_str = setting.sipnames
       
            peers = peers_str.split('|')
       
            i = n % peers.count
    
	    telephone = contact.telephone.gsub(/[^0-9A-Za-z]/, '').gsub(/\r\n?/, "\n").gsub(/\W/, '') 
    
            
	if (telephone.length == 11)
	    telephone.slice!(0)
	end
   
    
            if (telephone.length == 10) 
              telephone = '7' + telephone
            end
            
        puts telephone
   
       File.open(Dir::Tmpname.create(['tmp_' + peers[i] + '_', '.call']) { }.to_s, "w+") do |f|
    	    f.puts("Channel: SIP/" + telephone +  "@goldmedia2")
            f.puts("Callerid: " + peers[i])
            f.puts("MaxRetries: 0")
            f.puts("RetryTime: 20")
            f.puts("WaitTime: 7")
            f.puts("Context: outgoing")
            f.puts("Extension: s")
            f.puts("Priority: 1")       
            f_path = f.path
       end

#       File.open(Dir::Tmpname.create(['tmp_' + peers[i] + '_', '.call']) { }.to_s, "w+") do |f|
 #               f.puts("Channel: SIP/" + telephone +  "@" + peers[i])
  #                          f.puts("Callerid: " + contact.id.to_s)
   #                                     f.puts("Account: " + telephone)
    #                                                f.puts("MaxRetries: 0")
     #                                                           f.puts("RetryTime: 20")
      #                                                                      f.puts("WaitTime: 5")
       #                                                                                 f.puts("Context: outgoing")
        #                                                                                            f.puts("Extension: s")
         #                                                                                                       f.puts("Priority: 1")
                                                                                                                       
          #                                                                                                                         f_path = f.path
           #                                                                                                                        end       
       
           FileUtils.mv(f_path, setting.outgoing + '/' + File.basename(f_path))
       
           dir = setting.outgoing + '/'
           count = Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }
       
              
           if (j > setting.callcount)
              j = 0
              next
           end
            
            
        end
        
        
    end
    
  end

end
