class Trank < ApplicationRecord

    belongs_to :vote_welcome, class_name: "Vote", required: false
    belongs_to :vote_finish, class_name: "Vote", required: false
    belongs_to :vote_push_two, class_name: "Vote", required: false

    belongs_to :dialplan

    validates :name, presence: true
    validates :waittime, presence: true
    validates :callerid, presence: true
    validates :callcount, presence: true

    def initialize(attributes={})
      super
      config = Config.first
      self.context = config.default_trank_context
    end 

    def outgoing_total_count
        date = DateTime.now
		Outgoing.where(:updated_at => (date.beginning_of_day..date.end_of_day)).where(:trank => self).count
       # Outgoing.where(:updated_at => (date.beginning_of_day..date.end_of_day))
 #	.where(:status => ["DIALED", "ANSWERED", "NO ANSWER", "FAILED", "BUSY"]).count
    end

    def answer_total_count
        date = DateTime.now
	Answer.where(:updated_at => (date.beginning_of_day..date.end_of_day)).where(:trank => self).count
    end

    def outgoing_precent
        outgoing_count = self.outgoing_total_count

       if outgoing_count == 0
           0
       else 
            ((self.answer_total_count.to_f / outgoing_total_count.to_f) * 100).round(2) 
       end
    end


    def outgoing_answer_total_count
	date = DateTime.now
       Outgoing.where(:updated_at => (date.beginning_of_day..date.end_of_day))
        .where(:trank => self)
        .where(:status => ["ANSWERED"]).count
    end

    def outgoing_answer_precent
        outgoing_answer_count = self.outgoing_answer_total_count
	
        if outgoing_answer_count == 0 
  	    0
        else
            ((answer_total_count.to_f / outgoing_answer_total_count.to_f) * 100).round(2) 
        end
    end
        

    def check(telephone, account)
      setting = Setting.first
      Rails.logger.debug telephone
      Rails.logger.debug self.context
      telephone = self.prefix + telephone if self.prefix != nil

      File.open(Dir::Tmpname.create(['tmp_' + telephone + "_#{self.name}_", '.call']) { }.to_s, "w+") do |f|
                f.chmod(0666)
                f.puts("Channel: SIP/" + telephone +  "@#{self.name}")
                f.puts("Callerid: " + self.callerid)
                f.puts("MaxRetries: 0")
                f.puts("RetryTime: 20")
                f.puts("WaitTime: " + self.waittime.to_s)
            if (self.dialplan != nil)
                f.puts("Context: " + self.dialplan.name)
		        else
                f.puts("Context: from-trunk")
		        end
                f.puts("Extension: s")
                f.puts("Priority: 1")
            if (account != nil)
                f.puts("Account: " + account.to_s)
                f.puts("Set: num=" + account.to_s)
    			      f.puts("Set: CDR(userfield)=" + telephone)
            end
		        if (Config.first.is_vote_supported == true)
                f.puts("Set: vote_welcome=" + self.vote_welcome.record.path(:original).chomp('.wav')) if self.vote_welcome != nil
			          f.puts("Set: vote_finish=" + self.vote_finish.record.path(:original).chomp('.wav')) if self.vote_finish != nil
			          f.puts("Set: vote_push_two=" + self.vote_push_two.record.path(:original).chomp('.wav')) if self.vote_push_two != nil
            end
                #
                f.puts("Set: trunk=" + self.id.to_s)
                f.puts("Set: leadback_phone=" + setting.leadback_phone) if setting.leadback_phone != nil
                f.puts("Set: trunk_name=" + self.name)

		            FileUtils.mv(f.path, setting.outgoing + '/' + File.basename(f.path))
          end
    end
end
