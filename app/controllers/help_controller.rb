class HelpController < ApplicationController
 
  skip_before_action :require_login, :only => [:lead_incoming, :lead_update_dial_status]

  def cdr
    `sed -i 's/,/;/g' /var/log/asterisk/cdr-csv/Master.csv`
    send_file(
        "/var/log/asterisk/cdr-csv/Master.csv",
        filename: "Master.csv",
        type: "text/csv"
    )
  end
  def outgoing_destroy_all
    OutgoingDestroyAllJob.perform_later( )
    respond_to do |format|
      format.html { redirect_to outgoings_url, notice: 'Все записи удалены' }
      format.json { head :no_content }
    end
  end


  def cdr_clear
   # `rm -f /var/log/asterisk/cdr-csv/*.csv`
     `> /var/log/asterisk/cdr-csv/Master.csv`
    redirect_to outgoings_url, notice: 'Очистка журналов выполнено успешно'
  end

  def answers_destroy_all
    Answer.delete_all
    respond_to do |format|
       format.html {redirect_to answers_url, notice: 'Все записи удалены' }
       format.json { head :no_content }
    end
  end

  def cdr_destroy_all
    Asteriskcdr.delete_all
    respond_to do |format|
       format.html {redirect_to cdr_index_url, notice: 'Все записи удалены' }
       format.json { head :no_content }
    end

  end

  def asterisk_restart 
   `touch /tmp/asterisk.restart.marker`
  end

  def extensions
    id = params[:id]
    @extensions = Asteriskcdr.where(accountcode: id.to_s)
  end

  def trank_enable_all
    Trank.where(:enabled => false).each do |trank| 
      trank.update_attributes(:enabled => true)
    end
    redirect_to tranks_url, notice: "Все каналы активированы"
  end

  def trank_disable_all
    Trank.where(:enabled => true).each do |trank| 
        trank.update_attributes(:enabled => false)
    end
    redirect_to tranks_url, notice: "Все каналы деактивированы"
  end

 def trank_check
   trank = Trank.find(params[:id])
   telephone = params[:telephone]
   trank.check(telephone, telephone)
   redirect_to  tranks_url, notice: "Тестовый звонок на канал успешно отправлен"
 end

 def lead_incoming
   telephone = params[:telephone]
   trank = Trank.find(params[:trank])
   answer = Answer.create(:contact => telephone.squish, :trank => trank)
   @lead = Lead.create(:phone => telephone.squish, :answer => answer)
   employee_count = Employee.count
   if (employee_count > 0)
     employee_index = @lead.id % employee_count
     employee = Employee.all[employee_index]
     @lead.update_attributes(:employee => employee)
   end

   render :layout => false
 end

 def lead_update_dial_status
   lead_id = params[:id]
   dial_status = params[:dial_status]
   lead = Lead.find(lead_id)
   lead.update_attributes(:dialer_status => dial_status)
   render :layout => false
 end

end
