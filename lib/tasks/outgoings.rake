require 'fileutils'

namespace :outgoings do
  desc "TODO"
  task dialing: :environment do
    	
    puts "dialing"
    	
    setting = Setting.first
    total = (60 / setting.sleep).floor
    
    for t in 0..total
    
	sleep setting.sleep
	
	next    if (Setting.first.is_enabled != true)

	dir = setting.outgoing + '/'
	count = Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }
	
	j = count
    
	next   if (count > setting.callcount) 

	n = 0
	Outgoing.where(status: "INSERTED").limit(setting.callcount).each do |contact|
	
	
	puts contact.status
       
       contact.update(:status => 'DIALING') 
       contact.status = "DIALING"
       contact.save
       contact.errors.inspect
       
       puts Outgoing.where(:status => 'DIALING').count
       
	
	
	
	    n = n + 1
    	    j = j + 1
       
       f_path = ""
       
       peers_str = setting.sipnames
       
       peers = peers_str.split('|')
       
       i = n % peers.count
    
	telephone = contact.telephone.gsub(/[^0-9A-Za-z]/, '').gsub(/\r\n?/, "\n").gsub(/\W/, '') 
    
        if (telephone.length == 10) 
            telephone = '7' + telephone
        end
    
       File.open(Dir::Tmpname.create(['tmp_' + peers[i] + '_', '.call']) { }.to_s, "w+") do |f|
    	    f.puts("Channel: SIP/" + telephone +  "@" + peers[i])
            f.puts("Callerid: " + contact.id.to_s)
            f.puts("Account: " + telephone)
            f.puts("MaxRetries: 0")
            f.puts("RetryTime: 20")
            f.puts("WaitTime: 5")
            f.puts("Context: outgoing")
            f.puts("Extension: s")
            f.puts("Priority: 1")
       
            f_path = f.path
       end
       
       
       FileUtils.mv(f_path, setting.outgoing + '/' + File.basename(f_path))
       
       dir = setting.outgoing + '/'
       count = Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }
       
       setting.currentcount = count
       setting.update(currentcount: count)
              
       if (j > setting.callcount)
           j = 0
           next
       end

	
	
	end
	
    end

  end

end
