class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  skip_before_action :require_login, :only => [:index]

  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

#    @employee.sipaccount = Sipaccount.find(@employee.sipaccount)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def active
    employee = Employee.where(:name => params[:name]).first
    if (employee == nil)
      employee = Employee.create(:name => params[:name])
    end
    employee.update_attributes(:status => 1)

    setting = Setting.first

    for i in 0..setting.trunk_active_count - 1
      enable_trunks = Trank.where(:enable => false)
      enable_count = enable_trunks.length
      trunk = enable_trunks[rand(enable_count - 1)]
      trunk.update_attributes(:enable => true)
    end

    render plain: "OK"
  end

  def deactive
    employee = Employee.where(:name => params[:name]).first
    if (employee == nil)
      employee = Employee.create(:name => params[:name])
    end
    employee.update_attributes(:status => 0)

    for i in 0..setting.trunk_active_count - 1
      enable_trunks = Trank.where(:enable => true)
      enable_count = enable_trunks.length
      trunk = enable_trunks[rand(enable_count - 1)]
      trunk.update_attributes(:enable => false)
    end

    render plain: "OK"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:name, :password, :status, :sipaccount_id, :is_support_call)
    end
end
