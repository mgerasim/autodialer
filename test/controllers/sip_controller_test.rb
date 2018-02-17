require 'test_helper'

class SipControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get sip_show_url
    assert_response :success
  end

  test "should get edit" do
    get sip_edit_url
    assert_response :success
  end

end
