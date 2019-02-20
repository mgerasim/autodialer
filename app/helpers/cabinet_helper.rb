module CabinetHelper

  def cabinet_authenticate?(id, password)

    employee = Employee.find(id)

#    return false if employee == nil

    employee != nil and employee.password == password

  end

  def cabinet_in(employee)

    session[:employee] = employee

  end

  def cabinet_out

    session[:employee] = nil

  end
     
  def cabineted_in?
 
    session[:employee] != nil

  end

end
