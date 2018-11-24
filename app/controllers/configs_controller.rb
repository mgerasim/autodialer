class ConfigsController < ApplicationController
  include SessionsHelper
  before_action :require_admin
  before_action :set_config, only: [:show, :edit, :update, :destroy]

  # GET /configs
  # GET /configs.json
  def index
    @configs = Config.all
  end

  # GET /configs/1
  # GET /configs/1.json
  def show
  end

  # GET /configs/new
  def new
    @config = Config.new
  end

  # GET /configs/1/edit
  def edit
  end

  # POST /configs
  # POST /configs.json
  def create
    @config = Config.new(config_params)

    respond_to do |format|
      if @config.save
        format.html { redirect_to @config, notice: 'Конфигурация приложения успешно создана.' }
        format.json { render :show, status: :created, location: @config }
      else
        format.html { render :new }
        format.json { render json: @config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /configs/1
  # PATCH/PUT /configs/1.json
  def update
    respond_to do |format|
      if @config.update(config_params)
        format.html { redirect_to edit_config_path(@config), notice: 'Конфигурация приложения успешна обновлена.' }
        format.json { render :show, status: :ok, location: @config }
      else
        format.html { render :edit }
        format.json { render json: @config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /configs/1
  # DELETE /configs/1.json
  def destroy
    @config.destroy
    respond_to do |format|
      format.html { redirect_to configs_url, notice: 'Конфигурация приложения успешна удалена.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_config
      @config = Config.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def config_params
      params.require(:config).permit(:prefix_contry, :is_vote_supported, :is_menu_service_showed, :default_trank_context, :is_trank_context_showed, :password, :is_outgoing_deleted, :is_outgoing_table_showed, :is_google_integrated, :is_attempt_supported, :is_answer_supported)
    end

  private
    def require_admin
      unless is_admin?
        flash[:danger] = "Вы должны ввести пароль администратора"
        redirect_to login_path
      end
    end
end
