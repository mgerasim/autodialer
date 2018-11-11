class TranksController < ApplicationController
  before_action :set_trank, only: [:show, :edit, :update, :destroy]
  before_action :get_config
  # GET /tranks
  # GET /tranks.json
  def index
    @tranks = Trank.all
  end

  # GET /tranks/1
  # GET /tranks/1.json
  def show
  end

  # GET /tranks/new
  def new
    @trank = Trank.new
  end

  # GET /tranks/1/edit
  def edit
  end

  # POST /tranks
  # POST /tranks.json
  def create
    @trank = Trank.new(trank_params)

    respond_to do |format|
      if @trank.save
        format.html { redirect_to @trank, notice: 'Рабочий канал успешно создан.' }
        format.json { render :show, status: :created, location: @trank }
      else
        format.html { render :new }
        format.json { render json: @trank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tranks/1
  # PATCH/PUT /tranks/1.json
  def update
    respond_to do |format|
      if @trank.update(trank_params)
        format.html { redirect_to @trank, notice: 'Рабочий канал успешно обновлен.' }
        format.json { render :show, status: :ok, location: @trank }
      else
        format.html { render :edit }
        format.json { render json: @trank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tranks/1
  # DELETE /tranks/1.json
  def destroy
    @trank.destroy
    respond_to do |format|
      format.html { redirect_to tranks_url, notice: 'Рабочий канал успешно удален.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trank
      @trank = Trank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trank_params
      params.require(:trank).permit(:context, :name, :callerid, :prefix, :waittime, :callcount, :enabled)
    end
   
    def get_config
      @config = Config.first
    end
end
