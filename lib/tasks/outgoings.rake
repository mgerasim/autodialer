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
    
	next   if (count > 0) 

	n = 0
	j = 0
	Outgoing.where(status: "INSERTED").limit(setting.callcount).each do |contact|
	
	    n = n + 1
    	    j = j + 1
       
       f_path = ""
       
       peers_str = setting.sipnames
       
       peers = peers_str.split('|')
       
       i = n % peers.count
    
       File.open(Dir::Tmpname.create(['tmp_' + peers[i] + '_', '.call']) { }.to_s, "w+") do |f|
    	    f.puts("Channel: SIP/" + contact.telephone +  "@" + peers[i])
            f.puts("Callerid: " + contact.id.to_s)
            f.puts("Account: " + contact.id.to_s)
            f.puts("MaxRetries: 0")
            f.puts("RetryTime: 20")
            f.puts("WaitTime: 5")
            f.puts("Context: outgoing")
            f.puts("Extension: s")
            f.puts("Priority: 1")
       
            f_path = f.path
       end
       
       puts contact.status
       
       contact.update(:status => 'DIALING') 
       contact.status = "DIALING"
       contact.save
       contact.errors.inspect
       
       puts Outgoing.where(:status => 'DIALING').count
       
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
