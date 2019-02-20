class CabinetController < ApplicationController

  skip_before_action :require_login, :only => [:new, :create, :destroy]
  
  def new

    if cabineted_in?
      redirect_to cabinet_in_path
    end   

  end

  def create

    if cabinet_authenticate?(params[:cabinet][:employee], params[:cabinet][:password])

      cabinet_in

      flash[:success] = "Добро пожаловть в личный кабинет"

      redirect_to cabinet_in_path

    end

  end

  def destroy

      cabinet_out

      redirect_to root_url

  end
end
