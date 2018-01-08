require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "Д.б. форма авторизации" do
    get login_path
    assert_response :success
    assert_select "title", "Авторизация | Telecontact"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Авторизация | Telecontact"
  end


end
