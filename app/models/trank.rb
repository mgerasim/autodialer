class Trank < ApplicationRecord
    validates :name, presence: true
    validates :waittime, presence: true
    validates :callerid, presence: true
    validates :callcount, presence: true
   
    def check(telephone)
      setting = Setting.first
      puts telephone
      File.open(Dir::Tmpname.create(['tmp_' + telephone + "_#{self.name}_", '.call']) { }.to_s, "w+") do |f|
                    f.chmod(0666)
    	            f.puts("Channel: SIP/" + telephone +  "@#{self.name}")
                    f.puts("Callerid: " + self.callerid)
	            f.puts("MaxRetries: 0")
                    f.puts("RetryTime: 20")
                    f.puts("WaitTime: " + self.waittime.to_s)
                    f.puts("Context: from-trunk")
                    f.puts("Extension: s")
                    f.puts("Priority: 1")
		    FileUtils.mv(f.path, setting.outgoing + '/' + File.basename(f.path))     
      end
     

    end
end
