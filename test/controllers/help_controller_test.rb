require 'test_helper'

class HelpControllerTest < ActionDispatch::IntegrationTest
  test "should get outgoing_destroy_all" do
    get help_outgoing_destroy_all_url
    assert_response :success
  end

end
