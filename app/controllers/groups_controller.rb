class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :active, :deactive]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Группа каналов успешна создана.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Группа каналов успешна обновлена.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Группа каналов успешна удалена.' }
      format.json { head :no_content }
    end
  end

  def active
    @group.tranks.each do |trunk| 
      trunk.update_attributes(:enabled => true);
    end

    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Рабочие каналы в группе успешно активированы.' }
      format.json { head :no_content }
    end
  end

  def deactive
    @group.tranks.each do |trunk| 
      trunk.update_attributes(:enabled => false);
    end

    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Рабочие каналы в группе успешно деактивированы.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:title, trank_ids:[])
    end
end
