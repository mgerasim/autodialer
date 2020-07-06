class SipaccountsController < ApplicationController
  before_action :set_sipaccount, only: [:show, :edit, :update, :destroy]

  # GET /sipaccounts
  # GET /sipaccounts.json
  def index
    @sipaccounts = Sipaccount.all
  end

  # GET /sipaccounts/1
  # GET /sipaccounts/1.json
  def show
  end

  # GET /sipaccounts/new
  def new
    @sipaccount = Sipaccount.new
  end

  # GET /sipaccounts/1/edit
  def edit
  end

  # POST /sipaccounts
  # POST /sipaccounts.json
  def create
    @sipaccount = Sipaccount.new(sipaccount_params)

    respond_to do |format|
      if @sipaccount.save
        format.html { redirect_to @sipaccount, notice: 'Sipaccount was successfully created.' }
        format.json { render :show, status: :created, location: @sipaccount }
      else
        format.html { render :new }
        format.json { render json: @sipaccount.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sipaccounts/1
  # PATCH/PUT /sipaccounts/1.json
  def update
    respond_to do |format|
      if @sipaccount.update(sipaccount_params)
        format.html { redirect_to @sipaccount, notice: 'Sipaccount was successfully updated.' }
        format.json { render :show, status: :ok, location: @sipaccount }
      else
        format.html { render :edit }
        format.json { render json: @sipaccount.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sipaccounts/1
  # DELETE /sipaccounts/1.json
  def destroy
    @sipaccount.destroy
    respond_to do |format|
      format.html { redirect_to sipaccounts_url, notice: 'Sipaccount was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sipaccount
      @sipaccount = Sipaccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sipaccount_params
      params.require(:sipaccount).permit(:number, :password)
    end
end
