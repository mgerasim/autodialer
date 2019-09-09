class OutgoingsController < ApplicationController
  before_action :set_outgoing, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, :only => [:index]
  
  # GET /outgoings
  # GET /outgoings.json
  def index
    @outgoings = Outgoing.order(updated_at: :desc).limit(50)
    @outgoings_count = Outgoing.where(:status => 'INSERTED').count
    respond_to do |format|
 	format.html
#	format.csv { send_data Outgoing.where("EXISTS (select * from answers where INSTR(telephone, contact) = 0)").to_csv, filename: "autodialer-#{Date.today}.csv" }    
  format.csv { send_data Outgoing.all.to_csv, filename: "autodialer-#{Date.today}.csv" } 
  format.json { render :json => Outgoing.all, :except => [:created_at, :updated_at]}
    end
  end

  # GET /outgoings/1
  # GET /outgoings/1.json
  def show
  end

  # GET /outgoings/new
  def new
    @outgoing = Outgoing.new
  end

  # GET /outgoings/1/edit
  def edit
  end

  # POST /outgoings
  # POST /outgoings.json
  def create
    if ( !params.has_key?(:outgoing) ) 
        respond_to do |format|
        
            format.html { redirect_to new_outgoing_url, notice: 'Не выбран файл' }
            format.json { head :no_content }

          end
      else

        @outgoing = Outgoing.new(outgoing_params)
       
     #   OutgoingUploadJob.perform_later( @outgoing.csv_upload.path)
   
        path = @outgoing.csv_upload.path

        Rails.logger.error path
	
	upload = "LOAD DATA LOCAL INFILE '" + path + "' INTO TABLE outgoings (telephone) SET date_created = CURRENT_TIMESTAMP, status = 'INSERTED';"	
	
	results = ActiveRecord::Base.connection.execute(upload)
	
	Rails.logger.error results     
  
        respond_to do |format|
    	
          format.html { redirect_to outgoings_url, notice: 'Номера успешно добавлены' }
          format.json { head :no_content }

        end
      end
  end

  # PATCH/PUT /outgoings/1
  # PATCH/PUT /outgoings/1.json
  def update
    respond_to do |format|
      if @outgoing.update(outgoing_params)
        format.html { redirect_to @outgoing, notice: 'Outgoing was successfully updated.' }
        format.json { render :show, status: :ok, location: @outgoing }
      else
        format.html { render :edit }
        format.json { render json: @outgoing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outgoings/1
  # DELETE /outgoings/1.json
  def destroy
    @outgoing.destroy
    respond_to do |format|
      format.html { redirect_to outgoings_url, notice: 'Outgoing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def destroy_all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_outgoing
      @outgoing = Outgoing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def outgoing_params
      params.require(:outgoing).permit(:csv_upload)
    end
end
