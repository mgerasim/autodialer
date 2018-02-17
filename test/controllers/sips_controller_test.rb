require 'test_helper'

class SipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sip = sips(:one)
  end

  test "should get index" do
    get sips_url
    assert_response :success
  end

  test "should get new" do
    get new_sip_url
    assert_response :success
  end

  test "should create sip" do
    assert_difference('Sip.count') do
      post sips_url, params: { sip: { conf: @sip.conf } }
    end

    assert_redirected_to sip_url(Sip.last)
  end

  test "should show sip" do
    get sip_url(@sip)
    assert_response :success
  end

  test "should get edit" do
    get edit_sip_url(@sip)
    assert_response :success
  end

  test "should update sip" do
    patch sip_url(@sip), params: { sip: { conf: @sip.conf } }
    assert_redirected_to sip_url(@sip)
  end

  test "should destroy sip" do
    assert_difference('Sip.count', -1) do
      delete sip_url(@sip)
    end

    assert_redirected_to sips_url
  end
end
