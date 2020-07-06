require 'fileutils'

class TaskDailingJob < ApplicationJob
  queue_as :default

  def perform(task)
  
    task.update_attribute('status', "RUNNING")

    n = 0
    j = 0
    task.contacts.each do |contact| 
    
       n = n + 1
       j = j + 1
       
       f_path = ""
       
       setting = Setting.first
       
       peers_str = setting.sipnames
       
       peers = peers_str.split('|')
       
       i = n % peers.count
    
       File.open(Dir::Tmpname.create(['tmp_' + peers[i] + '_', '.call']) { }.to_s, "w+") do |f|
    	    f.puts("Channel: SIP/" + contact.phone +  "@" + peers[i])
            f.puts("Callerid: " + contact.id.to_s)
            f.puts("Account: " + task.id.to_s)
            f.puts("MaxRetries: 0")
            f.puts("RetryTime: 20")
            f.puts("WaitTime: 5")
            f.puts("Context: outgoing")
            f.puts("Extension: s")
            f.puts("Priority: 1")
       
            f_path = f.path
       end
       
       
       
       contact.update_attributes(:status => "DIALING", :peer => peers[i]) 
       
       FileUtils.mv(f_path, setting.outgoing + '/' + File.basename(f_path))
       
       dir = setting.outgoing + '/'
       count = Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }
       
       setting.currentcount = count
       setting.update(currentcount: count)
       
       call_count = Setting.first.callcount
       while count > 0 and j > call_count do
         count = Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }
         sleep setting.sleep
       end
       
       if (j > call_count)
           j = 0
       end
    
    end

    task.update_attribute('status', "COMPLETED")

  end
end

