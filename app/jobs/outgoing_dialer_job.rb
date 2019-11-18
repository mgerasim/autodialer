class OutgoingDialerJob < ApplicationJob
  queue_as :default

  def perform(outgoings, trunk, config)
    Rails.logger.debug "DIAL: JOB: Перешлив в фоновую задачу #{Time.now.strftime("%F %T")}"

    outgoings.each do |contact|

            if (contact.telephone == '')
              Rails.logger.debug "DIAL: JOB: TRUNK: " + trunk.name + " Пропускаем номер - пустое значение в телефоне : " + Time.now.strftime("%F %T")
            
              next
            end
            telephone = contact.telephone.gsub(/[^0-9A-Za-z]/, '').gsub(/\r\n?/, "\n").gsub(/\W/, '') 
            Rails.logger.debug "DIAL: JOB: TRUNK: " + trunk.name + " Выбран телефон: #{telephone}" + " : " + Time.now.strftime("%F %T") 

            if (telephone.length == 11)
              telephone.slice!(0)
            end 
            if (telephone.length == 10) 
              telephone = config.prefix_contry.to_s + telephone
            end
            Rails.logger.debug "DIAL: JOB: TRUNK: " + trunk.name + " Нормализация телефона: #{telephone}" + " : " + Time.now.strftime("%F %T") 

	    Rails.logger.debug "DIAL: JOB: TRUNK: " + trunk.name + " Звоним: #{telephone}" + " : " + Time.now.strftime("%F %T") 

            trunk.check(telephone, contact.id)
          end # Outgoings

  end
end
