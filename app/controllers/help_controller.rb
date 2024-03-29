class HelpController < ApplicationController
 
  skip_before_action :require_login, :only => [:trank_check, :employee_active, :employee_deactive, :lead_incoming, :lead_update_dial_status, :lead_get_employee_sipaccount]

  def employee_active

    employee = Employee.where(:name => params[:name]).first
    if (employee == nil)
      employee = Employee.create(:name => params[:name])

      employee.update_attributes(:status => 1)

      setting = Setting.first

      for i in 0..setting.trunk_active_count - 1
        enable_trunks = Trank.where(:enabled => false)
        enable_count = enable_trunks.count
        trunk = enable_trunks[rand(enable_count - 1)]
        trunk.update_attributes(:enabled => true)
      end
      
    else
      if employee.status != 1

        employee.update_attributes(:status => 1)

        setting = Setting.first

        for i in 0..setting.trunk_active_count - 1
          enable_trunks = Trank.where(:enabled => false)
          enable_count = enable_trunks.count
          trunk = enable_trunks[rand(enable_count - 1)]
          trunk.update_attributes(:enabled => true)
        end

      end
    end

    render plain: "OK"

  end

  def employee_deactive

    employee = Employee.where(:name => params[:name]).first
    if (employee == nil)
      employee = Employee.create(:name => params[:name])
      employee.update_attributes(:status => 0)
      setting = Setting.first
      for i in 0..setting.trunk_active_count - 1
        enable_trunks = Trank.where(:enabled => true)
        enable_count = enable_trunks.count
        trunk = enable_trunks[rand(enable_count - 1)] if enable_count > 0
        trunk.update_attributes(:enabled => false) if enable_count > 0
      end
    else
      if (employee.status != 0 )

        employee.update_attributes(:status => 0)
        setting = Setting.first
        for i in 0..setting.trunk_active_count - 1
          enable_trunks = Trank.where(:enabled => true)
          enable_count = enable_trunks.count
          trunk = enable_trunks[rand(enable_count - 1)] if enable_count > 0
          trunk.update_attributes(:enabled => false) if enable_count > 0
        end
      end
    end


    render plain: "OK"

  end

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
    %x( sudo service Autodial restart )
    redirect_to tranks_url, notice: "Все каналы активированы"
  end

  def trank_disable_all
    Trank.where(:enabled => true).each do |trank| 
        trank.update_attributes(:enabled => false)
    end
    %x( sudo service Autodial restart )
    redirect_to tranks_url, notice: "Все каналы деактивированы"
  end

 def trank_check
   trank = Trank.find(params[:id])
   dialplan = params[:dialplan]
   telephone = params[:telephone]
   trank.check(telephone, telephone, nil, dialplan)
   outgoing_id = params[:outgoing]
   if (outgoing_id == nil) 
     redirect_to  tranks_url, notice: "Тестовый звонок на канал успешно отправлен"
   else
      outgoing = Outgoing.find(outgoing_id) 
      outgoing.delete
      render plain: "OK"
   end
end

def upload_nodial

	file = Tempfile.new('no_dial', '/var/lib/mysql')

	file_path = file.path + '.csv'

	File.delete(file.path) if File.exist?(file.path)

	sql = "SELECT telephone FROM outgoings WHERE SUBSTR(telephone,2) NOT IN (SELECT contact FROM answers) AND status='DIALING' INTO OUTFILE '#{file_path}' FIELDS TERMINATED BY ',' ENCLOSED BY '' LINES TERMINATED BY '\n'"
        results = ActiveRecord::Base.connection.execute(sql)

	send_file file_path

end


 def lead_incoming
   telephone = params[:telephone]
   trank = Trank.find(params[:trank])
   answer = Answer.create(:contact => telephone.squish, :trank => trank)
   @lead = Lead.create(:phone => telephone.squish, :answer => answer)
   employeies = Employee.where(:status => 1)
   employee_count = employeies.count
   if (employee_count > 0)
     employee_index = @lead.id % employee_count
     employee = employeies[employee_index]
     @lead.update_attributes(:employee => employee)
   end
   render :layout => false
 end

 def lead_get_employee_sipaccount
   lead_id = params[:lead_id]
   puts lead_id
   @lead = Lead.find(lead_id)
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
