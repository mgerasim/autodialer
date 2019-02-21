class CabinetController < ApplicationController

  skip_before_action :require_login, :only => [:new, :create, :show, :destroy, :employee_status_change]
  
  def new

    if cabineted_in?
      redirect_to cabinet_show_path
    end   

  end

  def create

    if cabinet_authenticate?(params[:cabinet][:employee], params[:cabinet][:password])

      employee = Employee.find(params[:cabinet][:employee])

      cabinet_in(employee)

      flash[:success] = "Добро пожаловть в личный кабинет"

      redirect_to cabinet_show_path

    else

      flash.now[:danger] = 'Не верно указан пароль'

      render 'new'

    end

  end

  def destroy

      cabinet_out

      redirect_to root_url

  end

  def show
    @employee = Employee.find(session[:employee]['id'])
  end

  def employee_status_change

    @employee = Employee.find(session[:employee]['id'])

    @employee.update_attribute(:status , params[:status])

    flash.now[:success] = 'Статус успешно обновлен'

    render 'show'

  end

end
