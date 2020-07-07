require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  test "should get call" do
    get events_call_url
    assert_response :success
  end

  test "should get summary" do
    get events_summary_url
    assert_response :success
  end

  test "should get dtmf" do
    get events_dtmf_url
    assert_response :success
  end

  test "should get summary" do
    get events_summary_url
    assert_response :success
  end

end
