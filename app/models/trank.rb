class Trank < ApplicationRecord

    belongs_to :vote_welcome, class_name: "Vote"
    belongs_to :vote_finish, class_name: "Vote"
    belongs_to :vote_push_two, class_name: "Vote"

    validates :name, presence: true
    validates :waittime, presence: true
    validates :callerid, presence: true
    validates :callcount, presence: true

    def initialize(attributes={})
      super
      config = Config.first
      self.context = config.default_trank_context
    end 

    def check(telephone, account)
      setting = Setting.first
      Rails.logger.debug telephone
      Rails.logger.debug self.context
      File.open(Dir::Tmpname.create(['tmp_' + telephone + "_#{self.name}_", '.call']) { }.to_s, "w+") do |f|
                    f.chmod(0666)
    	            f.puts("Channel: SIP/" + telephone +  "@#{self.name}")
                    f.puts("Callerid: " + self.callerid)
	            f.puts("MaxRetries: 0")
                    f.puts("RetryTime: 20")
                    f.puts("WaitTime: " + self.waittime.to_s)
                    f.puts("Context: " + self.context)
                    f.puts("Extension: s")
                    f.puts("Priority: 1")
                    if (account != nil)
                        f.puts("Account: " + account.to_s)
                    	f.puts("Set: __num=" + account.to_s)
    			f.puts("Set: CDR(userfield)=" + telephone)
                    end
                    f.puts("Set: vote_welcome=" + self.vote_welcome.record.path(:wav).chomp('.mp3')) if self.vote_welcome != nil
		    FileUtils.mv(f.path, setting.outgoing + '/' + File.basename(f.path))     
      end
   

    end
end
