namespace :dial do
  desc "TODO"
  task clear: :environment do
    `rm -rf /var/log/asterisk/cdr-csv/`
    `mkdir /var/log/asterisk/cdr-csv/`
  end

  task :answer, [:contact] => :environment do |t, args|
    puts args.contact
    
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
    
    puts Time.now.hour
    
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
            next   if (count > trank.callcount)

            n = 0
            Outgoing.limit(trank.callcount).each do |contact|
                contact.delete
                n = n + 1
                j = j + 1
                f_path = ""
                peers_str = trank.callerid
                peers = peers_str.split('|')
                i = n % peers.count
	        telephone = contact.telephone.gsub(/[^0-9A-Za-z]/, '').gsub(/\r\n?/, "\n").gsub(/\W/, '')    
	        if (telephone.length == 11)
	            telephone.slice!(0)
	        end
   
                if (telephone.length == 10) 
                    telephone = '7' + telephone
                end

                telephone = trank.prefix + telephone
            
                puts telephone
  
                File.open(Dir::Tmpname.create(['tmp_' + peers[i] + "_#{trank.name}_", '.call']) { }.to_s, "w+") do |f|
                    f.chmod(0666)
    	            f.puts("Channel: SIP/" + telephone +  "@#{trank.name}")
                    f.puts("Callerid: " + peers[i])
                    f.puts("MaxRetries: 0")
                    f.puts("RetryTime: 20")
                    f.puts("WaitTime: " + trank.waittime.to_s)
                    f.puts("Context: from-trunk")
                    f.puts("Extension: s")
                    f.puts("Priority: 1")
                    f.puts("Account: " + contact.id.to_s)
                    f.puts("Set: CDR(num)=" + telephone)
                   # f.puts("Set: __num=" + telephone)
                    f_path = f.path
                end
                puts f_path

                FileUtils.mv(f_path, setting.outgoing + '/' + File.basename(f_path))
       
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
