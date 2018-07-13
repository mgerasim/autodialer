require 'test_helper'

class TranksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trank = tranks(:one)
  end

  test "should get index" do
    get tranks_url
    assert_response :success
  end

  test "should get new" do
    get new_trank_url
    assert_response :success
  end

  test "should create trank" do
    assert_difference('Trank.count') do
      post tranks_url, params: { trank: { callcount: @trank.callcount, callerid: @trank.callerid, enabled: @trank.enabled, name: @trank.name, waittime: @trank.waittime } }
    end

    assert_redirected_to trank_url(Trank.last)
  end

  test "should show trank" do
    get trank_url(@trank)
    assert_response :success
  end

  test "should get edit" do
    get edit_trank_url(@trank)
    assert_response :success
  end

  test "should update trank" do
    patch trank_url(@trank), params: { trank: { callcount: @trank.callcount, callerid: @trank.callerid, enabled: @trank.enabled, name: @trank.name, waittime: @trank.waittime } }
    assert_redirected_to trank_url(@trank)
  end

  test "should destroy trank" do
    assert_difference('Trank.count', -1) do
      delete trank_url(@trank)
    end

    assert_redirected_to tranks_url
  end
end
