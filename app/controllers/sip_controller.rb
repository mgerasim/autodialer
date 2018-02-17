class SipController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :save
  def show
   data = File.read("/etc/asterisk/sip.conf")
   @sip = data
   #@showpeers = `asterisk -rvx "sip show peers"`
   @showpeers = %x[asterisk -rvx "sip show peers"]
   logger.debug "test"
   logger.debug @showpeers
  end

  def edit   
    @sip = Sip.new
    data = File.read("/etc/asterisk/sip.conf")
    @sip.sipconf = data
  end
  
  def save
#    data = params[:txtarea]
#    File.open("/tmp/sip.conf.txt", "w+") do |f|
#      f.write(data)
#    end
    
    redirect_to show, notice: 'Конфигурация SIP успешно сохранена.' 
    
  end
  
private
    # Use callbacks to share common setup or constraints between actions.
    def set_sip
      @sip = Sip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sip_params
      params.require(:sip).permit(:sipconf)
    end

end
