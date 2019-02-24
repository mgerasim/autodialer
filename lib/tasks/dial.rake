require 'open3'

namespace :dial do

  pid_file = "/tmp/#{ENV['RAILS_ENV']}_dial_run.pid"

  desc "TODO"
  task clear: :environment do


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

  desc "Stop dial"
  task stop: :environment do
    Process.kill(15, File.read(pid_file).to_i)  if File.exist?(pid_file)
    File.delete(pid_file) if File.exist?(pid_file)
  end 


  desc "Run dial"
  task run: :environment do
    if File.exists? pid_file
      pid = File.read(pid_file).to_i

      begin
        Process.getpgid( pid )
        check_pid = true
      rescue Errno::ESRCH
        check_pid = false
      end

      File.delete(pid_file) if check_pid == false

    end

    raise 'pid file exists!' if File.exists? pid_file
    File.open(pid_file, 'w') { |f| f.puts Process.pid }

    puts Time.now.strftime("START:  %F %T")
    puts "PID: " + Process.pid.to_s

    loop do 
      begin
        
        sleep 1
        

        puts "PID: " + Process.pid.to_s
        puts Time.now.strftime("POLL: %F %T")

        File.open("/tmp/autodialer.log", 'w') { |f| f.puts Time.now }

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

        if (setting.sleep == nil)
          setting.update_attributes(:sleep => 1)
        end  

        if (!(setting.hour_bgn <= Time.now.hour and Time.now.hour < setting.hour_end))
                puts("out time")
        	next
        end

        config = Config.first
        puts Time.now.strftime("TRUNK:ALL: %F %T")

        tranks = Trank.where(:enabled => true)

        tranks.each do |trank|
            puts Time.now.strftime("TRUNK: %F %T")
	    puts "TRUNK: name=" + trank.name
            next if (!trank.enabled)
              
            puts "Этот транк активный"

            if trank.is_check_registered
              cmd = "asterisk -x \"sip show registry\" | awk ' $3 == \"#{trank.name}@m\" { print $5 }'"

              stdout, stderr, status = Open3.capture3(cmd)

              puts stdout

              puts stderr

              next if stdout != "Registered"
            end

            dir = setting.outgoing + '/'
            count = Dir[File.join(dir, '**', "*#{trank.name}*")].count { |file| File.file?(file) }
            j = count
            puts "-> Count:  #{count} Maxcall: #{trank.callmax}"
            next   if (count >= trank.callmax)

#            sleep trank.sleeptime

            n = 0
            Outgoing.where(:status => 'INSERTED').order(updated_at: :desc).limit(trank.callcount).each do |contact|                

		if (contact.telephone == '')
			contact.delete
			next
		end
                
                if (config.is_outgoing_deleted == true)
             		contact.delete
		else
                	contact.update_attributes(:status => 'DIALING', :trank => trank)
		end
                
                n = n + 1
                j = j + 1
                f_path = ""
    	        
                telephone = contact.telephone.gsub(/[^0-9A-Za-z]/, '').gsub(/\r\n?/, "\n").gsub(/\W/, '')    
    	        if (telephone.length == 11)
    	            telephone.slice!(0)
    	        end
   
                if (telephone.length == 10) 
                    telephone = config.prefix_contry.to_s + telephone
                end

                trank.check(telephone, contact.id) 

                dir = setting.outgoing + '/'
                count = Dir[File.join(dir, '**', "*#{trank.name}*")].count { |file| File.file?(file) }
                puts "-->#{count}"


              
               # if (j > trank.callcount)
               #     j = 0
               #     next
               # end # if
            end # Outgoing.where
          end # Trank.all
        puts Time.now.strftime("POLL END: %F %T")    
      rescue => error
        puts "rescue: " + $!.message 
      end
    end # loop  
  end # task

end
