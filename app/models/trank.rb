class Trank < ApplicationRecord

    belongs_to :vote_welcome, class_name: "Vote", required: false
    belongs_to :vote_finish, class_name: "Vote", required: false
    belongs_to :vote_push_two, class_name: "Vote", required: false

    belongs_to :dialplan
    belongs_to :dialplan_incoming, class_name: "Dialplan", required: false

    validates :name, presence: true
    validates :waittime, presence: true
    validates :callerid, presence: true
    validates :callcount, presence: true

    has_and_belongs_to_many :groups

    after_save :update_peers

    def shown_groups
        self.groups.collect(&:title).join(';')
    end

    def initialize(attributes={})
      super
      config = Config.first
      self.context = config.default_trank_context
    end 

    def outgoing_total_count
        date = DateTime.now
		Outgoing.where(:trank => self).count
    end

    def answer_total_count
        date = DateTime.now
	Answer.where(:trank => self).count
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
           #Outgoing.where(:trank => self).where(:status => ["ANSWERED"]).count
           Answer.where(:trank => self).where(:level => ["1", "2"]).count
    end

    def outgoing_answer_precent
        outgoing_answer_count = self.outgoing_answer_total_count
        if outgoing_answer_count == 0 
  	        0
        else
            ((answer_total_count.to_f / outgoing_answer_total_count.to_f) * 100).round(2) 
        end
    end

    def update_peers
        File.open("/home/rails/autodialer.sip.#{Rails.env}.conf", "w+") do |f|
            Trank.all.each do |trunk| 
                f.chmod(0666)
                f.puts("[#{trunk.name}](beeline)")
                f.puts("callbackextension=#{trunk.username}")
                f.puts("defaultuser=#{trunk.username}")
                f.puts("secret=#{trunk.password}")
                f.puts("fromuser=#{trunk.username}")
                f.puts("context=#{trunk.dialplan_incoming.name}") if trunk.dialplan_incoming != nil
                f.puts("")

            end
        end

        %x{sudo asterisk -rx "sip reload"}

    end

    def check(telephone, account, outgoing = nil, dialplan = nil)
      setting = Setting.first
      Rails.logger.debug telephone
      Rails.logger.debug self.context
      telephone = self.prefix + telephone if self.prefix != nil

      File.open(Dir::Tmpname.create(['tmp_' + telephone + "_#{self.name}_", '.call']) { }.to_s, "w+") do |f|
                f.chmod(0666)
                f.puts("Channel: SIP/#{self.name}/" + telephone )
                f.puts("Callerid: " + self.callerid)
                f.puts("MaxRetries: 0")
                f.puts("RetryTime: 20")
                f.puts("WaitTime: " + self.waittime.to_s)

		if (dialplan != nil)
			f.puts("Context: " + dialplan)
		else
	                if (self.dialplan != nil)
        	            f.puts("Context: " + self.dialplan.name)
                	else
                	    f.puts("Context: from-trunk")
	                end
		end

                f.puts("Extension: s")
                f.puts("Priority: 1")
                if (account != nil)
                    f.puts("Account: " + account.to_s)
                    f.puts("Set: num=" + account.to_s)
                    f.puts("Set: CDR(userfield)=" + telephone)
                end
                if (Config.first.is_vote_supported == true)
                    f.puts("Set: vote_welcome=" + self.vote_welcome.record.path(:original).chomp('.wav').chomp('.mp3')) if self.vote_welcome != nil
                    f.puts("Set: vote_finish=" + self.vote_finish.record.path(:original).chomp('.wav').chomp('.mp3')) if self.vote_finish != nil
                    f.puts("Set: vote_push_two=" + self.vote_push_two.record.path(:original).chomp('.wav').chomp('.mp3')) if self.vote_push_two != nil
                end

		f.puts("Set: vote_record=" + Vote.first.record.path(:original).chomp('.mp3')) if Vote.first != nil                

                f.puts("Set: trunk=" + self.id.to_s)
                f.puts("Set: leadback_phone=" + setting.leadback_phone) if setting.leadback_phone != nil
                f.puts("Set: trunk_name=" + self.name)
                f.puts("Set: rails_env=" + Rails.env)
                port = 3001
                if (Rails.env.production?)
			port = 80
		end
		f.puts("Set: curl_lead_incoming=http://localhost:#{port}/help/lead_incoming?telephone=#{telephone}&trank=#{self.id}")
                f.puts("Set: curl_lead_update_dial_status=http://localhost:#{port}/help/lead_update_dial_status?id=")
                f.puts("Set: curl_lead_get_employee_sipaccount=http://localhost:#{port}/help/lead_get_employee_sipaccount?lead_id=")
		f.puts("Set: outgoing=#{account}")
		            FileUtils.mv(f.path, setting.outgoing + '/' + File.basename(f.path))
          end
    end
end
