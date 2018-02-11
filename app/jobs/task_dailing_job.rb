require 'fileutils'

class TaskDailingJob < ApplicationJob
  queue_as :default

  def perform(task)

    task.contacts.each do |contact| 
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
       
       contact.update_attribute(:status, "DIALING") 

       FileUtils.mv(f.path, '/var/spool/asterisk/outgoing/' + File.basename(f.path))
       
       dir = '/var/spool/asterisk/outgoing/'
       count = Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }
       
       #count = 0
       while count > 30 do
         count = Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }
       end
      end
    end

  end
end
