class TranksController < ApplicationController
  skip_before_action :require_login, :only => [:index]
  before_action :set_trank, only: [:show, :edit, :update, :destroy, :distrib, :active, :deactive]
  before_action :get_config
  # GET /tranks
  # GET /tranks.json
  def index
    @tranks = Trank.all
    respond_to do |format|
      format.html
      format.json { render :json => @tranks, :include => :groups, :except => [:created_at, :updated_at]}
    end
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
         %x( sudo service Autodial restart )
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
         %x( sudo service Autodial restart )
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
    Outgoing.where(:trank => @trank).delete_all
    Answer.where(:trank => @trank).delete_all
    @trank.destroy
    respond_to do |format|
      format.html { redirect_to tranks_path, notice: 'Рабочий канал успешно удален.' }
      format.json { head :no_content }
    end
  end

  def distrib
    Trank.where.not(:id => @trank.id).each do |trunk|
      trunk.update_attributes(:waittime => @trank.waittime, :sleeptime => @trank.sleeptime, 
        :callcount => @trank.callcount, :callmax => @trank.callmax, :dialplan_id => @trank.dialplan_id,
	:prefix => @trank.prefix,
        :dialplan_incoming_id => @trank.dialplan_incoming_id,
	:vote_welcome_id => @trank.vote_welcome_id,
	:vote_push_two_id => @trank.vote_push_two_id,
	:vote_finish_id => @trank.vote_finish_id);
    end

    respond_to do |format|
      format.html { redirect_to tranks_path, notice: 'Настройки успешно распространены.' }
      format.json { head :no_content }
    end

  end


  def active
    @trank.update_attributes(:enabled => true);

    respond_to do |format|
      format.html { redirect_to tranks_url, notice: "Рабочий канал #{@trank.name} успешно активирован." }
      format.json { head :no_content }
    end
  end

  def deactive
    @trank.update_attributes(:enabled => false);
    respond_to do |format|
      format.html { redirect_to tranks_url, notice: "Рабочий канал #{@trank.name} успешно деактивирован." }
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
      params.require(:trank).permit(:is_check_registered, :dialplan_incoming_id, :dialplan_id, :vote_welcome_id, :vote_finish_id, :vote_push_two_id, :context, :name, :callerid, :prefix, :waittime, :callcount, :callmax, :sleeptime, :enabled, :password, :username, group_ids:[])
    end
   
    def get_config
      @config = Config.first
    end
end
