class DialplansController < ApplicationController
  before_action :set_dialplan, only: [:show, :edit, :update, :destroy]

  # GET /dialplans
  # GET /dialplans.json
  def index
    @dialplans = Dialplan.all
  end

  # GET /dialplans/1
  # GET /dialplans/1.json
  def show
  end

  # GET /dialplans/new
  def new
    @dialplan = Dialplan.new
  end

  # GET /dialplans/1/edit
  def edit
  end

  # POST /dialplans
  # POST /dialplans.json
  def create
    @dialplan = Dialplan.new(dialplan_params)

    respond_to do |format|
      if @dialplan.save
        format.html { redirect_to @dialplan, notice: 'Dialplan was successfully created.' }
        format.json { render :show, status: :created, location: @dialplan }
      else
        format.html { render :new }
        format.json { render json: @dialplan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dialplans/1
  # PATCH/PUT /dialplans/1.json
  def update
    respond_to do |format|
      if @dialplan.update(dialplan_params)
        format.html { redirect_to @dialplan, notice: 'Dialplan was successfully updated.' }
        format.json { render :show, status: :ok, location: @dialplan }
      else
        format.html { render :edit }
        format.json { render json: @dialplan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dialplans/1
  # DELETE /dialplans/1.json
  def destroy
    @dialplan.destroy
    respond_to do |format|
      format.html { redirect_to dialplans_url, notice: 'Dialplan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dialplan
      @dialplan = Dialplan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dialplan_params
      params.require(:dialplan).permit(:title, :name)
    end
end
