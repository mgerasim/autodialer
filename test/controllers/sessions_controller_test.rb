require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "Наличие формы авторизации" do
    get login_path
    assert_response :success
    assert_select "title", "Авторизация | Telecontact"
  end

  test "Наличие формы домашней страницы как форма авторизации" do
    get root_path
    assert_response :success
    assert_select "title", "Авторизация | Telecontact"
  end


end
