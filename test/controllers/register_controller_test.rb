require 'test_helper'

class RegisterControllerTest < ActionDispatch::IntegrationTest
  test "should get status" do
    get register_status_url
    assert_response :success
  end

  test "should get reload" do
    get register_reload_url
    assert_response :success
  end

end
