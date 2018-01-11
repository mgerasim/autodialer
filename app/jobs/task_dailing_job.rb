require 'fileutils'

class TaskDailingJob < ApplicationJob
  queue_as :default

  def perform(task)

    task.contacts.each do |contact| 
      File.open(Dir::Tmpname.create(['tmp', '.call']) { }.to_s, "w+") do |f|
       f.puts("Channel: SIP/89241086744@mtt")
       f.puts("Callerid: " + contact.id.to_s)
       f.puts("Account: " + task.id.to_s)
       f.puts("MaxRetries: 2")
       f.puts("RetryTime: 20")
       f.puts("WaitTime: 60")
       f.puts("Context: outgoing")
       f.puts("Extension: s")
       f.puts("Priority: 1")
       
       contact.update_attribute(:status, "DIALED") 

       FileUtils.mv(f.path, '/var/spool/asterisk/outgoing/' + File.basename(f.path))
      end
    end

  end
end
