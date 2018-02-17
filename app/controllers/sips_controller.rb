class SipsController < ApplicationController
  before_action :set_sip, only: [:show, :edit, :update, :destroy]

  # GET /sips
  # GET /sips.json
  def index
    @sips = Sip.all
  end

  # GET /sips/1
  # GET /sips/1.json
  def show
  end

  # GET /sips/new
  def new
    @sip = Sip.new
  end

  # GET /sips/1/edit
  def edit
  end

  # POST /sips
  # POST /sips.json
  def create
    @sip = Sip.new(sip_params)
    
    
    filename = "/etc/asterisk/sip.conf"
    
    filename = time_stamped_file(filename) 
    
    FileUtils.cp "/etc/asterisk/sip.conf", filename

    File.open("/etc/asterisk/sip.conf", "w+") do |f|
      f.write(@sip.sipconf)
    end
    
    system('asterisk -rvx "sip reload"')
    
    redirect_to sip_show_path, notice: 'Конфигурация SIP успешно сохранена.' 


#    respond_to do |format|
#      if @sip.save
#        format.html { redirect_to @sip, notice: 'Sip was successfully created.' }
#        format.json { render :show, status: :created, location: @sip }
#      else
#        format.html { render :new }
#        format.json { render json: @sip.errors, status: :unprocessable_entity }
#      end
#    end
  end

  # PATCH/PUT /sips/1
  # PATCH/PUT /sips/1.json
  def update
    respond_to do |format|
      if @sip.update(sip_params)
        format.html { redirect_to @sip, notice: 'Sip was successfully updated.' }
        format.json { render :show, status: :ok, location: @sip }
      else
        format.html { render :edit }
        format.json { render json: @sip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sips/1
  # DELETE /sips/1.json
  def destroy
    @sip.destroy
    respond_to do |format|
      format.html { redirect_to sips_url, notice: 'Sip was successfully destroyed.' }
      format.json { head :no_content }
    end
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
    
    def time_stamped_file(file)
      file.gsub(/\./,"_" + Time.now.strftime("%m-%d_%H-%M-%S") + '.') 
    end
    
end
