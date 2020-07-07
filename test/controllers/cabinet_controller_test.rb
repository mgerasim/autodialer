require 'test_helper'

class CabinetControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get cabinet_new_url
    assert_response :success
  end

  test "should get create" do
    get cabinet_create_url
    assert_response :success
  end

  test "should get destroy" do
    get cabinet_destroy_url
    assert_response :success
  end

end
