require 'fileutils'

class TaskDailingJob < ApplicationJob
  queue_as :default

  def perform(task)

    task.contacts.each do |contact| 
    
       f_path = ""
    
       File.open(Dir::Tmpname.create(['tmp', '.call']) { }.to_s, "w+") do |f|
    	    f.puts("Channel: SIP/" + contact.phone +  "@mtt2")
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
       
       contact.update_attribute(:status, "DIALING") 

       setting = Setting.first
       
       FileUtils.mv(f_path, setting.outgoing + '/' + File.basename(f_path))
       
       dir = setting.outgoing + '/'
       count = Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }
       
       setting.currentcount = count
       setting.update(currentcount: count)
       
       call_count = Setting.first.callcount
       while count > call_count do
         count = Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }
         sleep 1
       end
       
       
    
#      File.open(Dir::Tmpname.create(['tmp', '.call']) { }.to_s, "w+") do |f|
#       f.puts("Channel: SIP/" + contact.phone +  "@mtt2")
#       f.puts("Callerid: " + contact.id.to_s)
#       f.puts("Account: " + task.id.to_s)
#       f.puts("MaxRetries: 0")
#       f.puts("RetryTime: 20")
#       f.puts("WaitTime: 5")
#       f.puts("Context: outgoing")
#       f.puts("Extension: s")
#       f.puts("Priority: 1")
       
#       contact.update_attribute(:status, "DIALING") 

#       setting = Setting.first

#       FileUtils.mv(f.path, setting.outgoing + '/' + File.basename(f.path))
       
#       dir = setting.outgoing + '/'
#       count = Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }
       
#       setting.currentcount = count
#       setting.update(currentcount: count)
       
#       call_count = Setting.first.callcount
#       while count > call_count do
#         count = Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }
#       end
#      end
    end

  end
end

