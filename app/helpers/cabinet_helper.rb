module CabinetHelper

  def cabinet_authenticate?(id, password)

    employee = Employee.find(id)

#    return false if employee == nil

    employee != nil and employee.password == password

  end

  def cabinet_in

    session[:cabinet_in] = true

  end

  def cabinet_out

    session[:cabinet_in] = false

  end
     
  def cabineted_in?
 
    session[:cabinet_in]

  end

end
