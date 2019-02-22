class LeadStatusesController < ApplicationController
  before_action :set_lead_status, only: [:show, :edit, :update, :destroy]

  # GET /lead_statuses
  # GET /lead_statuses.json
  def index
    @lead_statuses = LeadStatus.all
  end

  # GET /lead_statuses/1
  # GET /lead_statuses/1.json
  def show
  end

  # GET /lead_statuses/new
  def new
    @lead_status = LeadStatus.new
  end

  # GET /lead_statuses/1/edit
  def edit
  end

  # POST /lead_statuses
  # POST /lead_statuses.json
  def create
    @lead_status = LeadStatus.new(lead_status_params)

    respond_to do |format|
      if @lead_status.save
        format.html { redirect_to @lead_status, notice: 'Lead status was successfully created.' }
        format.json { render :show, status: :created, location: @lead_status }
      else
        format.html { render :new }
        format.json { render json: @lead_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lead_statuses/1
  # PATCH/PUT /lead_statuses/1.json
  def update
    respond_to do |format|
      if @lead_status.update(lead_status_params)
        format.html { redirect_to @lead_status, notice: 'Lead status was successfully updated.' }
        format.json { render :show, status: :ok, location: @lead_status }
      else
        format.html { render :edit }
        format.json { render json: @lead_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lead_statuses/1
  # DELETE /lead_statuses/1.json
  def destroy
    @lead_status.destroy
    respond_to do |format|
      format.html { redirect_to lead_statuses_url, notice: 'Lead status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lead_status
      @lead_status = LeadStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lead_status_params
      params.require(:lead_status).permit(:image, :title, :name)
    end
end
