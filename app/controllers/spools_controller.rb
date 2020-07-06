class SpoolsController < ApplicationController
  before_action :set_spool, only: [:show, :edit, :update, :destroy]

  # GET /spools
  # GET /spools.json
  def index
    @spools = Spool.all
  end

  # GET /spools/1
  # GET /spools/1.json
  def show
  end

  # GET /spools/new
  def new
    @spool = Spool.new
  end

  # GET /spools/1/edit
  def edit
  end

  # POST /spools
  # POST /spools.json
  def create
    @spool = Spool.new(spool_params)

    respond_to do |format|
      if @spool.save
        format.html { redirect_to @spool, notice: 'Spool was successfully created.' }
        format.json { render :show, status: :created, location: @spool }
      else
        format.html { render :new }
        format.json { render json: @spool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spools/1
  # PATCH/PUT /spools/1.json
  def update
    respond_to do |format|
      if @spool.update(spool_params)
        format.html { redirect_to @spool, notice: 'Spool was successfully updated.' }
        format.json { render :show, status: :ok, location: @spool }
      else
        format.html { render :edit }
        format.json { render json: @spool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spools/1
  # DELETE /spools/1.json
  def destroy
    @spool.destroy
    respond_to do |format|
      format.html { redirect_to spools_url, notice: 'Spool was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spool
      @spool = Spool.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def spool_params
      params.require(:spool).permit(:answer_id)
    end
end
